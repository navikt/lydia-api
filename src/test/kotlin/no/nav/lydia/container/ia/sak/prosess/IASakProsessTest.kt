package no.nav.lydia.container.ia.sak.prosess

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikk
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKontaktes
import no.nav.lydia.helper.hentIAProsesser
import no.nav.lydia.helper.nyttNavnPåProsess
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import kotlin.test.Test

class IASakProsessTest {

    @Test
    fun `skal få tildelt en prosess ved overgang fra KONTAKTES til KARTLEGGES`() {
        val sakIKontaktes = nySakIKontaktes()
        sakIKontaktes.hentIAProsesser() shouldHaveSize 0

        val sakIKartlegges = sakIKontaktes.nyHendelse(hendelsestype = IASakshendelseType.VIRKSOMHET_KARTLEGGES)
        sakIKartlegges.hentIAProsesser() shouldHaveSize 1
    }

    @Test
    fun `skal beholde tildelt prosess selvom man går frem og TILBAKE i saksgang`() {
        val sakIKartlegges = nySakIKartlegges()
        val prosesser = sakIKartlegges.hentIAProsesser()
        prosesser shouldHaveSize 1

        val tildeltProsess = prosesser[0]

        val sakIKartleggesTilbakeOgFrem = sakIKartlegges.nyHendelse(hendelsestype = IASakshendelseType.TILBAKE)
            .nyHendelse(hendelsestype = IASakshendelseType.VIRKSOMHET_KARTLEGGES)
        val prosesserEtterTilbakeOgFrem = sakIKartleggesTilbakeOgFrem.hentIAProsesser()
        prosesserEtterTilbakeOgFrem shouldHaveSize 1

        prosesserEtterTilbakeOgFrem[0] shouldBe tildeltProsess
    }

    @Test
    fun `skal kunne endre navn på en prosess`() {
        val sak = nySakIKartlegges()
        sak.opprettKartlegging() // dette burde opprette en prosess

        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1

        val prosess = prosesser.first()
        val nyttNavn = "Nytt navn"
        sak.nyttNavnPåProsess(prosess, nyttNavn).hentIAProsesser().first().navn shouldBe nyttNavn
    }

    @Test
    fun `skal kunne hente ut alle aktive prosesser i en sak`() {
        val sak = nySakIKartlegges()
        sak.opprettKartlegging() // dette burde opprette en prosess

        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1
        prosesser.first().saksnummer shouldBe sak.saksnummer
    }

    @Test
    fun `skal ikke få feil i historikken dersom man endrer navn på prosess flere ganger`() {
        val sak = nySakIKartlegges()
        sak.opprettKartlegging() // dette burde opprette en prosess

        val prosesser = sak.hentIAProsesser()
        prosesser shouldHaveSize 1

        val prosess = prosesser.first()
        sak.nyttNavnPåProsess(prosess, "Første")
            .nyttNavnPåProsess(prosess, "Andre")
            .nyttNavnPåProsess(prosess, "Tredje")
            .hentIAProsesser().first().navn shouldBe "Tredje"

        val samarbeidshistorikk = hentSamarbeidshistorikk(
            sak.orgnr
        )
        samarbeidshistorikk shouldHaveSize 1
        val sakshendelser = samarbeidshistorikk.first().sakshendelser
        sakshendelser shouldHaveSize 8
        sakshendelser.map { it.hendelsestype } shouldBe listOf(
            IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
            IASakshendelseType.VIRKSOMHET_VURDERES,
            IASakshendelseType.TA_EIERSKAP_I_SAK,
            IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
            IASakshendelseType.VIRKSOMHET_KARTLEGGES,
            IASakshendelseType.ENDRE_PROSESS,
            IASakshendelseType.ENDRE_PROSESS,
            IASakshendelseType.ENDRE_PROSESS
        )
        sakshendelser.last().status shouldBe IAProsessStatus.KARTLEGGES
    }
}
