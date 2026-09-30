package no.nav.lydia.container.ny.flyt.plan

import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.api.v1.NY_FLYT_API_PATH
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.featureToggleForNavEnhet
import no.nav.lydia.featureToggle.FeatureToggleVerdier
import no.nav.lydia.featureToggle.ToggleVerdi
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.tilSingelRespons
import kotlin.test.Test
import kotlin.test.fail

class FeatureTogglingTest {
    private val togglenavn = NyFlytTestUtils.NAVENHETER_NY_PLAN
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
        val url = "$NY_FLYT_API_PATH/feature-toggling/$togglenavn/${TestContainerHelper.NAVENHET_TEST_SAKSBEHANDLER2}"
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
    fun `saksbehandler skal få 404 for en ukjent toggel`() {
        val url = "$NY_FLYT_API_PATH/feature-toggling/ukjent-toggel/${TestContainerHelper.NAVENHET_TEST_SAKSBEHANDLER2}"
        val respons = applikasjon.performGet(url)
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<ToggleVerdi>()

        respons.second.statusCode shouldBe HttpStatusCode.NotFound.value
    }

    @Test
    fun `lesebruker skal ikke ha tilgang til å spørre om feature-toggling for en gitt verdi`() {
        val url = "$NY_FLYT_API_PATH/feature-toggling/$togglenavn/${TestContainerHelper.NAVENHET_TEST_SAKSBEHANDLER2}"
        val respons = applikasjon.performGet(url)
            .authentication().bearer(authContainerHelper.lesebruker.token)
            .tilSingelRespons<ToggleVerdi>()

        respons.second.statusCode shouldBe HttpStatusCode.Forbidden.value
    }

    @Test
    fun `uten token skal spørring om feature-toggling for en gitt verdi avvises`() {
        val url = "$NY_FLYT_API_PATH/feature-toggling/$togglenavn/${TestContainerHelper.NAVENHET_TEST_SAKSBEHANDLER2}"
        val respons = applikasjon.performGet(url).tilSingelRespons<ToggleVerdi>()

        respons.second.statusCode shouldBe HttpStatusCode.Unauthorized.value
    }

    @Test
    fun `superbruker skal få verdiene som er skrudd på for en toggel`() {
        val url = "$NY_FLYT_API_PATH/feature-toggling/$togglenavn"
        val respons = applikasjon.performGet(url)
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<FeatureToggleVerdier>()

        respons.third.fold(
            success = { it.verdier shouldBe setOf(TestContainerHelper.NAVENHET_TEST_SAKSBEHANDLER2) },
            failure = { fail(it.message) },
        )
    }

    @Test
    fun `superbruker skal få 404 for en ukjent toggel`() {
        val url = "$NY_FLYT_API_PATH/feature-toggling/ukjent-toggel"
        val respons = applikasjon.performGet(url)
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<FeatureToggleVerdier>()

        respons.second.statusCode shouldBe HttpStatusCode.NotFound.value
    }

    @Test
    fun `saksbehandler skal ikke ha tilgang til å hente verdiene for en toggel`() {
        val url = "$NY_FLYT_API_PATH/feature-toggling/$togglenavn"
        val respons = applikasjon.performGet(url)
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<FeatureToggleVerdier>()

        respons.second.statusCode shouldBe HttpStatusCode.Forbidden.value
    }

    @Test
    fun `uten token skal henting av verdiene for en toggel avvises`() {
        val url = "$NY_FLYT_API_PATH/feature-toggling/$togglenavn"
        val respons = applikasjon.performGet(url).tilSingelRespons<FeatureToggleVerdier>()

        respons.second.statusCode shouldBe HttpStatusCode.Unauthorized.value
    }
}
