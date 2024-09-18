package no.nav.lydia.container.ia.sak.prosess

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus
import io.kotest.assertions.shouldFail
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikk
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.hentIAProsesser
import no.nav.lydia.helper.nyttNavnPåProsess
import no.nav.lydia.helper.opprettNyProsses
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import kotlin.test.Test

class IASakProsessTest {
    @Test
    fun `skal beholde tildelt prosess selvom man går frem og TILBAKE i saksgang`() {
        val sakIKartlegges = nySakIKartlegges()
            .nyHendelse(hendelsestype = IASakshendelseType.NY_PROSESS)
        val prosesser = sakIKartlegges.hentIAProsesser()
        prosesser shouldHaveSize 1

        val tildeltProsess = prosesser.first()

        val sakIKartleggesTilbakeOgFrem = sakIKartlegges
            .nyHendelse(hendelsestype = IASakshendelseType.TILBAKE)
            .nyHendelse(hendelsestype = IASakshendelseType.VIRKSOMHET_KARTLEGGES)
        val prosesserEtterTilbakeOgFrem = sakIKartleggesTilbakeOgFrem.hentIAProsesser()
        prosesserEtterTilbakeOgFrem shouldHaveSize 1

        prosesserEtterTilbakeOgFrem[0] shouldBe tildeltProsess
    }

    @Test
    fun `skal kunne opprette flere prosesser på samme sak`() {
        val sakIKartlegges = nySakIKartlegges()
            .nyHendelse(hendelsestype = IASakshendelseType.NY_PROSESS)
        sakIKartlegges.hentIAProsesser() shouldHaveSize 1

        sakIKartlegges.nyHendelse(IASakshendelseType.NY_PROSESS).hentIAProsesser() shouldHaveSize 2
    }

    @Test
    fun `skal kunne opprette kartlegginger på saker der det er flere prosesser`() {
        val sakIKartlegges = nySakIKartlegges()
            .nyHendelse(hendelsestype = IASakshendelseType.NY_PROSESS)
        sakIKartlegges.hentIAProsesser() shouldHaveSize 1

        val sakMedFlereProsesser = sakIKartlegges.nyHendelse(IASakshendelseType.NY_PROSESS)
        sakMedFlereProsesser.hentIAProsesser() shouldHaveSize 2

        val kartlegging = sakMedFlereProsesser.opprettKartlegging()
        kartlegging.status shouldBe SpørreundersøkelseStatus.OPPRETTET
    }

    @Test
    fun `skal kunne endre navn på en prosess`() {
        val sak = nySakIKartlegges()
            .nyHendelse(hendelsestype = IASakshendelseType.NY_PROSESS)
        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1

        val prosess = prosesser.first()
        val nyttNavn = "Nytt navn"
        sak.nyttNavnPåProsess(prosess, nyttNavn).hentIAProsesser().first().navn shouldBe nyttNavn
    }

    @Test
    fun `skal kunne hente ut alle aktive prosesser i en sak`() {
        val sak = nySakIKartlegges()
            .nyHendelse(hendelsestype = IASakshendelseType.NY_PROSESS)

        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1
        prosesser.first().saksnummer shouldBe sak.saksnummer
    }

    @Test
    fun `skal ikke få feil i historikken dersom man endrer navn på prosess flere ganger`() {
        val sak = nySakIKartlegges()
            .nyHendelse(hendelsestype = IASakshendelseType.NY_PROSESS)

        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1

        val prosess = prosesser.first()
        sak.nyttNavnPåProsess(prosess, "Første")
            .nyttNavnPåProsess(prosess, "Andre")
            .nyttNavnPåProsess(prosess, "Tredje")
            .hentIAProsesser().first().navn shouldBe "Tredje"

        val samarbeidshistorikk = hentSamarbeidshistorikk(
            sak.orgnr,
        )
        samarbeidshistorikk shouldHaveSize 1
        val sakshendelser = samarbeidshistorikk.first().sakshendelser
        sakshendelser shouldHaveSize 9
        sakshendelser.map { it.hendelsestype } shouldBe listOf(
            IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
            IASakshendelseType.VIRKSOMHET_VURDERES,
            IASakshendelseType.TA_EIERSKAP_I_SAK,
            IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
            IASakshendelseType.VIRKSOMHET_KARTLEGGES,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.ENDRE_PROSESS,
            IASakshendelseType.ENDRE_PROSESS,
            IASakshendelseType.ENDRE_PROSESS,
        )
        sakshendelser.last().status shouldBe IAProsessStatus.KARTLEGGES
    }

    @Test
    fun `skal ikke få feil i sakshistorikk dersom man sletter flere samarbeid på rad`() {
        val sak = nySakIKartlegges()
            .opprettNyProsses()
            .opprettNyProsses()

        val samarbeid = sak.hentIAProsesser()
        samarbeid shouldHaveSize 2

        sak.nyHendelse(
            hendelsestype = IASakshendelseType.SLETT_PROSESS,
            payload = Json.encodeToString(samarbeid.first())
        ).nyHendelse(
            hendelsestype = IASakshendelseType.SLETT_PROSESS,
            payload = Json.encodeToString(samarbeid.last())
        )
        sak.hentIAProsesser() shouldHaveSize 0

        val samarbeidshistorikk = hentSamarbeidshistorikk(
            sak.orgnr,
        )
        samarbeidshistorikk shouldHaveSize 1
        val sakshendelser = samarbeidshistorikk.first().sakshendelser
        sakshendelser shouldHaveSize 9
        sakshendelser.map { it.hendelsestype } shouldBe listOf(
            IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
            IASakshendelseType.VIRKSOMHET_VURDERES,
            IASakshendelseType.TA_EIERSKAP_I_SAK,
            IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
            IASakshendelseType.VIRKSOMHET_KARTLEGGES,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.SLETT_PROSESS,
            IASakshendelseType.SLETT_PROSESS,
        )
        sakshendelser.last().status shouldBe IAProsessStatus.KARTLEGGES
    }

    @Test
    fun `skal ikke få feil i historikken dersom man oppretter flere prosesser på rad`() {
        val sak = nySakIKartlegges()
            .nyHendelse(hendelsestype = IASakshendelseType.NY_PROSESS)

        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1

        sak.opprettNyProsses()
            .opprettNyProsses()
            .opprettNyProsses()
            .hentIAProsesser() shouldHaveSize 4

        val flereProsesser = sak.hentIAProsesser()
        flereProsesser shouldHaveSize 4

        val samarbeidshistorikk = hentSamarbeidshistorikk(
            sak.orgnr,
        )
        samarbeidshistorikk shouldHaveSize 1
        val sakshendelser = samarbeidshistorikk.first().sakshendelser
        sakshendelser shouldHaveSize 9
        sakshendelser.map { it.hendelsestype } shouldBe listOf(
            IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
            IASakshendelseType.VIRKSOMHET_VURDERES,
            IASakshendelseType.TA_EIERSKAP_I_SAK,
            IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
            IASakshendelseType.VIRKSOMHET_KARTLEGGES,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.NY_PROSESS,
        )
        sakshendelser.last().status shouldBe IAProsessStatus.KARTLEGGES
    }

    @Test
    fun `skal kunne slette tomme prosesser`() {
        val sak = nySakIKartlegges().nyHendelse(IASakshendelseType.NY_PROSESS)
        val prosesserFørSletting = sak.hentIAProsesser()
        prosesserFørSletting shouldHaveSize 1

        val prosessSomSkalSlettes = prosesserFørSletting.first()
        sak.nyHendelse(
            hendelsestype = IASakshendelseType.SLETT_PROSESS,
            payload = Json.encodeToString(prosessSomSkalSlettes)
        )

        val prosesserEtterSletting = sak.hentIAProsesser()
        prosesserEtterSletting shouldBe emptyList()
    }

    @Test
    fun `skal ikke kunne slette prosesser som har en behovsvurdering knyttet til seg`() {
        val sak = nySakIKartlegges().nyHendelse(IASakshendelseType.NY_PROSESS)
        val prosesserFørSletting = sak.hentIAProsesser()
        val prosessSomSkalForsøkesSlettes = prosesserFørSletting.first()
        sak.opprettKartlegging(prosessId = prosessSomSkalForsøkesSlettes.id)
        shouldFail {
            sak.nyHendelse(
                hendelsestype = IASakshendelseType.SLETT_PROSESS,
                payload = Json.encodeToString(prosessSomSkalForsøkesSlettes)
            )
        }
        sak.hentIAProsesser() shouldBe prosesserFørSletting
    }

    @Test
    fun `skal ikke kunne slette prosesser som har en plan knyttet til seg`() {
        val sak = nySakIKartlegges().nyHendelse(IASakshendelseType.NY_PROSESS)
        val prosesserFørSletting = sak.hentIAProsesser()
        val prosessSomSkalForsøkesSlettes = prosesserFørSletting.first()
        PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = prosessSomSkalForsøkesSlettes.id
        )

        shouldFail {
            sak.nyHendelse(
                hendelsestype = IASakshendelseType.SLETT_PROSESS,
                payload = Json.encodeToString(prosessSomSkalForsøkesSlettes)
            )
        }
        sak.hentIAProsesser() shouldBe prosesserFørSletting
    }

    @Test
    fun `skal få feilmelding dersom man sender inn feil data ved sletting`() {
        val sak = nySakIKartlegges()

        shouldFail {
            sak.nyHendelse(
                hendelsestype = IASakshendelseType.SLETT_PROSESS,
                payload = Json.encodeToString(IAProsessDto(
                    id = 1010000,
                    saksnummer = sak.saksnummer,
                ))
            )
        }
    }

    @Test
    fun `skal ikke lagre SLETT_PROSESS hendelse dersom sletting ikke er lov`() {
        val sak = nySakIKartlegges().opprettNyProsses()
        val samarbeid = sak.hentIAProsesser()
        samarbeid shouldHaveSize 1

        sak.opprettKartlegging()

        shouldFail {
            sak.nyHendelse(
                hendelsestype = IASakshendelseType.SLETT_PROSESS,
                payload = Json.encodeToString(IAProsessDto(
                    id = 1010000,
                    saksnummer = sak.saksnummer,
                ))
            )
        }

        val samarbeidEtterSlett = sak.hentIAProsesser()
        samarbeidEtterSlett shouldHaveSize 1

        val sisteHendelse = TestContainerHelper.postgresContainer.hentEnkelKolonne<String>("""
            select id from ia_sak_hendelse where saksnummer = '${sak.saksnummer}' order by  opprettet desc limit 1
        """.trimIndent())
        sisteHendelse shouldBe sak.endretAvHendelseId
    }
}
