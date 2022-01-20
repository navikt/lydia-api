package no.nav.lydia

import io.ktor.http.*
import io.ktor.server.testing.*
import java.net.URL
import kotlin.test.Test
import kotlin.test.assertEquals

class AppTest {
    private val naisEnv = NaisEnvironment(
        database = Database( // TODO vi må legge til database-config her om vi skal gjøre noe mer enn helsesjekk-kall
            host = "",
            port = "",
            username = "",
            password = "",
            name = ""
        ), security = Security(
            AzureConfig(
                audience = "",
                jwksUri = URL("https://www.example.com"),
                issuer = ""
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

}
