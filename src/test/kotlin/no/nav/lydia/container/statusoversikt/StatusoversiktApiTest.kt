package no.nav.lydia.container.statusoversikt

import io.kotest.matchers.ints.shouldBeGreaterThan
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.SakHelper.Companion.fullførSak
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.StatusoversiktHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestData.Companion.BARNEHAGER_SOM_NÆRINGSGRUPPE
import no.nav.lydia.helper.TestData.Companion.OPPFØRING_AV_BYGNINGER
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.virksomhet.domene.Sektor
import kotlin.test.Test

class StatusoversiktApiTest {
    @Test
    fun `skal hente statusoversikt for de som ikke er aktive`() {
        VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet = TestVirksomhet.nyVirksomhet())

        val statusoversiktKommunalSektor =
            StatusoversiktHelper.hentStatusoversikt(
                sektor = Sektor.KOMMUNAL.kode,
                token = authContainerHelper.superbruker1.token,
            ).third.get().data

        statusoversiktKommunalSektor.size shouldBeGreaterThan 0
        statusoversiktKommunalSektor.first { statusoversikt ->
            statusoversikt.status == IASak.Status.IKKE_AKTIV
        }.antall shouldBeGreaterThan 0
    }

    @Test
    fun `skal ikke kunne hente statusoversikt dersom man ikke er superbruker, saksbehandler eller lesebruker`() {
        StatusoversiktHelper.hentStatusoversikt(
            token = authContainerHelper.brukerUtenTilgangsrolle.token,
        ).second.statusCode shouldBe 403
        StatusoversiktHelper.hentStatusoversikt(
            token = authContainerHelper.saksbehandler1.token,
        ).second.statusCode shouldBe 200
        StatusoversiktHelper.hentStatusoversikt(
            token = authContainerHelper.superbruker1.token,
        ).second.statusCode shouldBe 200
        StatusoversiktHelper.hentStatusoversikt(
            token = authContainerHelper.lesebruker.token,
        ).second.statusCode shouldBe 200
    }

    @Test
    fun `skal kunne filtrere på sektor`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(
            nyVirksomhet = TestVirksomhet.nyVirksomhet(),
            sektor = Sektor.KOMMUNAL,
        )

        nySakIViBistår(orgnummer = virksomhet.orgnr)
            .fullførSak()

        val aktivSak = hentSak(orgnummer = virksomhet.orgnr)
        aktivSak.status shouldBe IASak.Status.FULLFØRT

        val statusoversiktKommunalSektor =
            StatusoversiktHelper.hentStatusoversikt(
                sektor = Sektor.KOMMUNAL.kode,
                token = authContainerHelper.superbruker1.token,
            ).third.get().data
        statusoversiktKommunalSektor.size shouldBeGreaterThan 0
        statusoversiktKommunalSektor.first { statusoversikt ->
            statusoversikt.status == IASak.Status.FULLFØRT
        }.antall shouldBeGreaterThan 0
    }

    @Test
    fun `skal kunne filtrere på næring eller bransje`() {
        val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(
            nyVirksomhet = TestVirksomhet.nyVirksomhet(
                næringer = listOf(OPPFØRING_AV_BYGNINGER),
            ),
        )
        nySakIViBistår(orgnummer = virksomhet.orgnr)
            .fullførSak()
        val aktivSak = hentSak(orgnummer = virksomhet.orgnr)
        aktivSak.status shouldBe IASak.Status.FULLFØRT

        VirksomhetHelper.lastInnNyVirksomhet(
            nyVirksomhet = TestVirksomhet.nyVirksomhet(
                næringer = listOf(BARNEHAGER_SOM_NÆRINGSGRUPPE),
            ),
        )

        val statusoversiktResults =
            StatusoversiktHelper.hentStatusoversikt(
                næringsgrupper = "41",
                bransjeProgram = "BARNEHAGER",
                token = authContainerHelper.superbruker1.token,
            ).third.get().data

        statusoversiktResults.size shouldBeGreaterThan 1
        statusoversiktResults.first { statusoversikt ->
            statusoversikt.status == IASak.Status.FULLFØRT
        }.antall shouldBeGreaterThan 0
        statusoversiktResults.first { statusoversikt ->
            statusoversikt.status == IASak.Status.IKKE_AKTIV
        }.antall shouldBeGreaterThan 0
    }
}
