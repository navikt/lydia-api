package no.nav.lydia

import io.ktor.http.*
import io.ktor.server.testing.*
import no.nav.lydia.container.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.security.mock.oauth2.MockOAuth2Server
import java.net.URL
import kotlin.test.Test
import kotlin.test.assertEquals

class AppTest {
    companion object {
        val mockOAuth2Server = MockOAuth2Server().apply {
            start(8100)
        }

    }

    private val naisEnv = NaisEnvironment(
        database = Database( // TODO vi må legge til database-config her om vi skal gjøre noe mer enn helsesjekk-kall
            host = "",
            port = "",
            username = "",
            password = "",
            name = ""
        ), security = Security(
            AzureConfig(
                audience = "lydia-api",
                jwksUri = URL("http://localhost:8100/default/jwks"),
                issuer = "http://localhost:8100/default"
            )
        )
    )

    @Test
    fun `appen svarer på isAlive-kall når den kjører`() {
        withTestApplication({ lydiaBackend(naisEnv) }) {
            with(handleRequest(HttpMethod.Get, "/internal/isalive")) {
                assertEquals(HttpStatusCode.OK, response.status())
                assertEquals("OK", response.content)
            }
        }
    }

    @Test
    fun `appen svarer på isReady-kall når den er klar til å ta imot trafikk`() {
        withTestApplication({ lydiaBackend(naisEnv) }) {
            with(handleRequest(HttpMethod.Get, "/internal/isready")) {
                //TODO sørg for at database-tilkoblingen funker før vi svarer ja på isReady
                assertEquals(HttpStatusCode.OK, response.status())
                assertEquals("OK", response.content)
            }
        }
    }

    @Test
    fun `Uautorisert kall mot beskyttet endepunkt skal returnere 401`() {
        withTestApplication({ lydiaBackend(naisEnv) }) {
            with(handleRequest(HttpMethod.Get, "$SYKEFRAVERSSTATISTIKK_PATH/protected")) {
                assertEquals(HttpStatusCode.Unauthorized, response.status())
            }
        }
    }

    @Test
    fun `Kall med ugyldig token mot beskyttet endepunkt skal returnere 401`() {
        withTestApplication({ lydiaBackend(naisEnv) }) {
            with(handleRequest(HttpMethod.Get, "$SYKEFRAVERSSTATISTIKK_PATH/protected") {
                addHeader(HttpHeaders.Authorization, "Bearer detteErIkkeEtGyldigToken")
            }) {
                assertEquals(HttpStatusCode.Unauthorized, response.status())
            }
        }
    }

    @Test
    fun `Innlogget nav ansatt skal kunne nå beskyttede endepunkt`() {
        withTestApplication({ lydiaBackend(naisEnv) }) {
            val token = mockOAuth2Server.issueToken(
                audience = "lydia-api", claims = mapOf(
                    "NAVident" to "X12345"
                )
            ).serialize()

            with(handleRequest(HttpMethod.Get, "$SYKEFRAVERSSTATISTIKK_PATH/protected") {
                addHeader(HttpHeaders.Authorization, "Bearer $token")
            }) {
                assertEquals(HttpStatusCode.OK, response.status())
            }
        }
    }
}
