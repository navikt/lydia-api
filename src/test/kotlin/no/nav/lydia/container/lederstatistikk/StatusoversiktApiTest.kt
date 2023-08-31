package no.nav.lydia.container.lederstatistikk

import io.kotest.matchers.ints.shouldBeGreaterThan
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.SakHelper.Companion.hentAktivSak
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.StatusoversiktHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
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
}
