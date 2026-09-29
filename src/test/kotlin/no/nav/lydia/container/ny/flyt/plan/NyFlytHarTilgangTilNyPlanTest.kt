package no.nav.lydia.container.ny.flyt.plan

import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.api.v1.NY_FLYT_API_PATH
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.brukerHarTilgangTilNyPlan
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.samarbeidsplan.BrukerHarTilgang
import kotlin.test.Test

class NyFlytHarTilgangTilNyPlanTest {
    private val url = "$NY_FLYT_API_PATH/virksomhet/har-tilgang-til-ny-plan"

    @Test
    fun `saksbehandler i en NAV-enhet uten tilgang til ny plan skal få harTilgang false`() {
        val respons = brukerHarTilgangTilNyPlan(authContainerHelper.saksbehandler1.token)

        respons.harTilgang.shouldBe(false)
    }

    @Test
    fun `saksbehandler i en NAV-enhet med tilgang til ny plan skal få harTilgang true`() {
        val respons = brukerHarTilgangTilNyPlan(authContainerHelper.saksbehandler2.token)

        respons.harTilgang shouldBe true
    }

    @Test
    fun `lesebruker skal ikke ha tilgang til å spørre om ny plan-tilgang`() {
        val respons = applikasjon.performGet(url)
            .authentication().bearer(authContainerHelper.lesebruker.token)
            .tilSingelRespons<BrukerHarTilgang>()

        respons.second.statusCode shouldBe HttpStatusCode.Forbidden.value
    }

    @Test
    fun `uten token skal spørring om ny plan-tilgang avvises`() {
        val respons = applikasjon.performGet(url).tilSingelRespons<BrukerHarTilgang>()

        respons.second.statusCode shouldBe HttpStatusCode.Unauthorized.value
    }
}
