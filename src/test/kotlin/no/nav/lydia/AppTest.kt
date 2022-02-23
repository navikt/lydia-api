package no.nav.lydia

import io.ktor.http.*
import io.ktor.server.testing.*
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.sykefraversstatistikk.api.FILTERVERDIER_PATH
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.security.mock.oauth2.MockOAuth2Server
import java.net.URL
import kotlin.test.Test
import kotlin.test.assertEquals

class AppTest {
    companion object {
        val mockOAuth2Server = MockOAuth2Server().apply {
            start(port = 8100)
        }
        val postgres = TestContainerHelper.postgresContainer
        val dataSource = postgres.getDataSource().apply { runMigration(this) }
        val naisEnvironment = NaisEnvironment(
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
                )
            ), kafka = Kafka(
                brokers = "",
                truststoreLocation = "",
                keystoreLocation = "",
                credstorePassword = "",
                statistikkTopic = "",
                consumerLoopDelay = 200L
            ), brreg = Brreg(underEnhetUrl = "/brregmock/enhetsregisteret/api/underenheter/lastned")
        )
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

    @Test
    fun `innlogget nav ansatt skal kunne nå beskyttede endepunkt`() {
        withTestApplication({ lydiaRestApi(naisEnvironment = naisEnvironment, dataSource = dataSource) }) {
            val token = mockOAuth2Server.issueToken(
                audience = "lydia-api", claims = mapOf(
                    "NAVident" to "X12345"
                )
            ).serialize()

            with(handleRequest(HttpMethod.Get, SYKEFRAVERSSTATISTIKK_PATH) {
                addHeader(HttpHeaders.Authorization, "Bearer $token")
            }) {
                assertEquals(HttpStatusCode.OK, response.status())
            }

            // Kaller samme endepunkt bare med en trailing slash foran
            with(handleRequest(HttpMethod.Get, "$SYKEFRAVERSSTATISTIKK_PATH/") {
                addHeader(HttpHeaders.Authorization, "Bearer $token")
            }) {
                assertEquals(HttpStatusCode.OK, response.status())
            }
        }
    }
}
