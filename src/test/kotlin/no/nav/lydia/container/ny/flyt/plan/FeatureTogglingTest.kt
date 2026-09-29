package no.nav.lydia.container.ny.flyt.plan

import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.api.v1.NY_FLYT_API_PATH
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.featureToggleForNavEnhet
import no.nav.lydia.featureToggle.FeatureToggleEnvironment
import no.nav.lydia.featureToggle.ToggleVerdi
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.tilSingelRespons
import kotlin.test.Test
import kotlin.test.fail

class FeatureTogglingTest {
    private val togglenavn = FeatureToggleEnvironment.NAVENHETER_MED_NY_PLAN_TILGANG
    private val navEnhetUrl = "$NY_FLYT_API_PATH/feature-toggling/nav-enhet/$togglenavn"

    @Test
    fun `saksbehandler i en NAV-enhet der toggelen ikke er skrudd på skal få erPå false`() {
        val respons = featureToggleForNavEnhet(token = authContainerHelper.saksbehandler1.token)

        respons.erPå.shouldBe(false)
    }

    @Test
    fun `saksbehandler i en NAV-enhet der toggelen er skrudd på skal få erPå true`() {
        val respons = featureToggleForNavEnhet(token = authContainerHelper.saksbehandler2.token)

        respons.erPå shouldBe true
    }

    @Test
    fun `lesebruker skal ikke ha tilgang til å spørre om feature-toggling for egen nav-enhet`() {
        val respons = applikasjon.performGet(navEnhetUrl)
            .authentication().bearer(authContainerHelper.lesebruker.token)
            .tilSingelRespons<ToggleVerdi>()

        respons.second.statusCode shouldBe HttpStatusCode.Forbidden.value
    }

    @Test
    fun `uten token skal spørring om feature-toggling for egen nav-enhet avvises`() {
        val respons = applikasjon.performGet(navEnhetUrl).tilSingelRespons<ToggleVerdi>()

        respons.second.statusCode shouldBe HttpStatusCode.Unauthorized.value
    }

    @Test
    fun `saksbehandler skal få erPå true når verdi er skrudd på for toggelen`() {
        val url = "$NY_FLYT_API_PATH/feature-toggling/$togglenavn/${FeatureToggleEnvironment.NAVENHET_TEST_SAKSBEHANDLER2}"
        val respons = applikasjon.performGet(url)
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<ToggleVerdi>()

        respons.third.fold(
            success = { it.erPå shouldBe true },
            failure = { fail(it.message) },
        )
    }

    @Test
    fun `saksbehandler skal få erPå false når verdi ikke er skrudd på for toggelen`() {
        val url = "$NY_FLYT_API_PATH/feature-toggling/$togglenavn/en-annen-verdi"
        val respons = applikasjon.performGet(url)
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<ToggleVerdi>()

        respons.third.fold(
            success = { it.erPå shouldBe false },
            failure = { fail(it.message) },
        )
    }

    @Test
    fun `saksbehandler skal få erPå false for en ukjent toggel`() {
        val url = "$NY_FLYT_API_PATH/feature-toggling/ukjent-toggel/${FeatureToggleEnvironment.NAVENHET_TEST_SAKSBEHANDLER2}"
        val respons = applikasjon.performGet(url)
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<ToggleVerdi>()

        respons.third.fold(
            success = { it.erPå shouldBe false },
            failure = { fail(it.message) },
        )
    }

    @Test
    fun `lesebruker skal ikke ha tilgang til å spørre om feature-toggling for en gitt verdi`() {
        val url = "$NY_FLYT_API_PATH/feature-toggling/$togglenavn/${FeatureToggleEnvironment.NAVENHET_TEST_SAKSBEHANDLER2}"
        val respons = applikasjon.performGet(url)
            .authentication().bearer(authContainerHelper.lesebruker.token)
            .tilSingelRespons<ToggleVerdi>()

        respons.second.statusCode shouldBe HttpStatusCode.Forbidden.value
    }

    @Test
    fun `uten token skal spørring om feature-toggling for en gitt verdi avvises`() {
        val url = "$NY_FLYT_API_PATH/feature-toggling/$togglenavn/${FeatureToggleEnvironment.NAVENHET_TEST_SAKSBEHANDLER2}"
        val respons = applikasjon.performGet(url).tilSingelRespons<ToggleVerdi>()

        respons.second.statusCode shouldBe HttpStatusCode.Unauthorized.value
    }
}
