package no.nav.lydia

import io.ktor.http.*
import io.ktor.server.testing.*
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.sykefraversstatistikk.api.FILTERVERDIER_PATH
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.security.mock.oauth2.MockOAuth2Server
import org.junit.AfterClass
import java.net.URL
import kotlin.test.Test
import kotlin.test.assertEquals

class AppTest {
    companion object {
        private val mockOAuth2Server = MockOAuth2Server().apply {
            start(port = 8100)
        }
        private val postgres = TestContainerHelper.postgresContainer
        private val dataSource = postgres.getDataSource().apply { runMigration(this) }
        private val naisEnvironment = NaisEnvironment(
            database = Database(
                host = "",
                port = "",
                username = "",
                password = "",
                name = "",
            ), security = Security(
                AzureConfig(
                    audience = "lydia-api",
                    jwksUri = URL("http://localhost:8100/default/jwks"),
                    issuer = "http://localhost:8100/default"
                ), fiaRoller = FiaRoller(
                    superbrukerGroupId = "123",
                    saksbehandlerGroupId = "456",
                    lesetilgangGroupId = "789"
                )
            ), kafka = Kafka(
                brokers = "",
                truststoreLocation = "",
                keystoreLocation = "",
                credstorePassword = "",
                statistikkTopic = "",
                consumerLoopDelay = 200L
            ), integrasjoner = Integrasjoner(
                ssbNæringsUrl = "/naringmock/api/klass/v1/30/json",
                brregUnderEnhetUrl = "/brregmock/enhetsregisteret/api/underenheter/lastned"
            ),
            cluster = "lokal"
        )

        @AfterClass
        @JvmStatic
        fun afterAll() {
            mockOAuth2Server.shutdown()
        }
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
    fun `uautorisert kall mot beskyttet endepunkt skal returnere 401`() {
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
}
