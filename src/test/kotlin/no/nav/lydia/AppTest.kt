package no.nav.lydia

import io.ktor.http.*
import io.ktor.server.testing.*
import no.nav.lydia.NaisEnvironment.Companion.Environment.LOKALT
import no.nav.lydia.appstatus.FEATURE_TOGGLE_TEST_PATH
import no.nav.lydia.helper.KtorTestHelper
import no.nav.lydia.helper.PostgrestContainerHelper
import no.nav.lydia.sykefraversstatistikk.api.FILTERVERDIER_PATH
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import org.junit.Before
import kotlin.test.Test
import kotlin.test.assertEquals

class AppTest {
    companion object {
        private val postgres = PostgrestContainerHelper()
        private val dataSource = postgres.getDataSource().apply { runMigration(this) }
        private val naisEnvironment = KtorTestHelper.ktorNaisEnvironment
    }

    @Before
    fun setUp() {
        UnleashKlient.init(miljø = LOKALT)
    }

    @Test
    fun `appen svarer på isAlive-kall når den kjører`() {
        withTestApplication({ lydiaRestApi(naisEnvironment = naisEnvironment, dataSource = dataSource) }) {
            with(handleRequest(HttpMethod.Get, "/internal/isalive")) {
                assertEquals(HttpStatusCode.OK, response.status())
                assertEquals("OK", response.content)
            }
        }
    }

    @Test
    fun `appen svarer på isReady-kall når den er klar til å ta imot trafikk`() {
        withTestApplication({ lydiaRestApi(naisEnvironment = naisEnvironment, dataSource = dataSource) }) {
            with(handleRequest(HttpMethod.Get, "/internal/isready")) {
                //TODO sørg for at database-tilkoblingen funker før vi svarer ja på isReady
                assertEquals(HttpStatusCode.OK, response.status())
                assertEquals("OK", response.content)
            }
        }
    }

    @Test
    fun `uautentisert kall mot beskyttet endepunkt skal returnere 401`() {
        withTestApplication({ lydiaRestApi(naisEnvironment = naisEnvironment, dataSource = dataSource) }) {
            with(handleRequest(HttpMethod.Get, "$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")) {
                assertEquals(HttpStatusCode.Unauthorized, response.status())
            }
        }
    }

    @Test
    fun `kall med ugyldig token mot beskyttet endepunkt skal returnere 401`() {
        withTestApplication({ lydiaRestApi(naisEnvironment = naisEnvironment, dataSource = dataSource) }) {
            with(handleRequest(HttpMethod.Get, "$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH") {
                addHeader(HttpHeaders.Authorization, "Bearer detteErIkkeEtGyldigToken")
            }) {
                assertEquals(HttpStatusCode.Unauthorized, response.status())
            }
        }
    }

    @Test
    fun `featuretoggling virker`() {
        UnleashKlient.skruAvToggle(UnleashToggleKeys.testToggle)
        withTestApplication({ lydiaRestApi(naisEnvironment = naisEnvironment, dataSource = dataSource) }) {
            with(handleRequest(HttpMethod.Get, FEATURE_TOGGLE_TEST_PATH)) {
                assertEquals(HttpStatusCode.NotImplemented, response.status())
            }
        }
        UnleashKlient.skruPåToggle(UnleashToggleKeys.testToggle)
        withTestApplication({ lydiaRestApi(naisEnvironment = naisEnvironment, dataSource = dataSource) }) {
            with(handleRequest(HttpMethod.Get, FEATURE_TOGGLE_TEST_PATH)) {
                assertEquals(HttpStatusCode.OK, response.status())
            }
        }
    }
}
