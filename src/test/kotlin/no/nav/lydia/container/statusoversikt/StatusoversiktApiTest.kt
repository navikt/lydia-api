package no.nav.lydia.container.statusoversikt

import io.kotest.matchers.ints.shouldBeGreaterThan
import io.kotest.matchers.shouldBe
import no.nav.lydia.container.sykefraversstatistikk.SykefraversstatistikkApiTest
import no.nav.lydia.helper.SakHelper.Companion.hentAktivSak
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.StatusoversiktHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.sykefraversstatistikk.api.SnittFilter
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.Sektor
import kotlin.test.Test

class StatusoversiktApiTest {
    private val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    @Test
    fun `skal hente statusoversikt for de som ikke er aktive`() {
        VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet = TestVirksomhet.nyVirksomhet())

        val statusoversiktKommunalSektor =
            StatusoversiktHelper.hentStatusoversikt(
                sektor = Sektor.KOMMUNAL.kode,
                token = mockOAuth2Server.superbruker1.token
            ).third.get().data

        statusoversiktKommunalSektor.size shouldBeGreaterThan 0
        statusoversiktKommunalSektor.first { statusoversikt ->
            statusoversikt.status == IAProsessStatus.IKKE_AKTIV
        }.antall shouldBeGreaterThan 0
    }

    @Test
    fun `skal ikke kunne hente statusoversikt dersom man ikke er superbruker eller saksbehandler`() {
        StatusoversiktHelper.hentStatusoversikt(
            token = mockOAuth2Server.lesebruker.token
        ).second.statusCode shouldBe 403
        StatusoversiktHelper.hentStatusoversikt(
            token = mockOAuth2Server.saksbehandler1.token
        ).second.statusCode shouldBe 200
        StatusoversiktHelper.hentStatusoversikt(
            token = mockOAuth2Server.superbruker1.token
        ).second.statusCode shouldBe 200
    }

    @Test
    fun `skal kunne filtrere på sektor`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet = TestVirksomhet.nyVirksomhet(),
            sektor = Sektor.KOMMUNAL)

        nySakIViBistår(orgnummer = virksomhet.orgnr)
            .nyHendelse(IASakshendelseType.FULLFØR_BISTAND)

        val aktivSak = hentAktivSak(orgnummer = virksomhet.orgnr)
        aktivSak.status shouldBe IAProsessStatus.FULLFØRT

        val statusoversiktKommunalSektor =
            StatusoversiktHelper.hentStatusoversikt(
                sektor = Sektor.KOMMUNAL.kode,
                token = mockOAuth2Server.superbruker1.token
            ).third.get().data
        statusoversiktKommunalSektor.size shouldBeGreaterThan 0
        statusoversiktKommunalSektor.first { statusoversikt ->
            statusoversikt.status == IAProsessStatus.FULLFØRT
        }.antall shouldBeGreaterThan 0
    }

    @Test
    fun `skal kunne filtrere på næring eller bransje`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(
            nyVirksomhet = TestVirksomhet.nyVirksomhet(
                næringer = listOf(Næringsgruppe("Boligbyggelag", "41.101"))
            )
        )
        nySakIViBistår(orgnummer = virksomhet.orgnr)
            .nyHendelse(IASakshendelseType.FULLFØR_BISTAND)
        val aktivSak = hentAktivSak(orgnummer = virksomhet.orgnr)
        aktivSak.status shouldBe IAProsessStatus.FULLFØRT

        VirksomhetHelper.lastInnNyVirksomhet(
            nyVirksomhet = TestVirksomhet.nyVirksomhet(
                næringer = listOf(Næringsgruppe("Barnehager", "88.911"))
            )
        )

        val statusoversiktResults =
            StatusoversiktHelper.hentStatusoversikt(
                næringsgrupper = "41",
                bransjeProgram = "BARNEHAGER",
                token = mockOAuth2Server.superbruker1.token
            ).third.get().data

        statusoversiktResults.size shouldBeGreaterThan 1
        statusoversiktResults.first { statusoversikt ->
            statusoversikt.status == IAProsessStatus.FULLFØRT
        }.antall shouldBeGreaterThan 0
        statusoversiktResults.first { statusoversikt ->
            statusoversikt.status == IAProsessStatus.IKKE_AKTIV
        }.antall shouldBeGreaterThan 0
    }

    @Test
    fun `skal kunne filtrere på næring eller bransje gjennomsnitt`() {
        val NÆRING_JORDBRUK_PROSENT = 6.0
        val NÆRING_SKOGBRUK_PROSENT = 8.5

        SykefraversstatistikkApiTest.settSykefraværsprosentNæring(TestData.NÆRING_JORDBRUK, NÆRING_JORDBRUK_PROSENT)
        SykefraversstatistikkApiTest.lagVirksomhetMedNæringsundergruppeOgSykefraværsprosent(
            Næringsgruppe("Dyrking av ris", "01.120"),
            4.0
        )
        SykefraversstatistikkApiTest.lagVirksomhetMedNæringsundergruppeOgSykefraværsprosent(
            Næringsgruppe("Planteformering", "01.300"),
            15.0
        )
        SykefraversstatistikkApiTest.settSykefraværsprosentNæring(TestData.NÆRING_SKOGBRUK, NÆRING_SKOGBRUK_PROSENT)
        SykefraversstatistikkApiTest.lagVirksomhetMedNæringsundergruppeOgSykefraværsprosent(
            Næringsgruppe("Skogskjøtsel og andre skogbruksaktiviteter", "02.100"),
            8.4
        )
        SykefraversstatistikkApiTest.lagVirksomhetMedNæringsundergruppeOgSykefraværsprosent(
            Næringsgruppe("Avvirkning", "02.200"),
            8.6
        )

        val statusoversiktResults = StatusoversiktHelper.hentStatusoversikt(
            snittFilter = SnittFilter.BRANSJE_NÆRING_OVER.name,
            næringsgrupper = listOf(TestData.NÆRING_JORDBRUK, TestData.NÆRING_SKOGBRUK).joinToString { "," }
        ).third.get().data

        statusoversiktResults.size shouldBeGreaterThan 0
        statusoversiktResults.first { statusoversikt ->
            statusoversikt.status == IAProsessStatus.IKKE_AKTIV
        }.antall shouldBeGreaterThan 1
    }
}
