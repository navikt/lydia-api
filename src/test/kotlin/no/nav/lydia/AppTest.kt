package no.nav.lydia

import io.ktor.http.*
import io.ktor.server.testing.*
import java.net.URL
import kotlin.test.Test
import kotlin.test.assertEquals

class AppTest {
    private val naisEnv = NaisEnvironment(
        database = Database(
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
    fun appHasAGreeting() {
        withTestApplication({ lydiaBackend(naisEnv) }) {
            with(handleRequest(HttpMethod.Get, "/isAlive")) {
                assertEquals("OK", response.content)
            }
        }
    }

}
