package no.nav.lydia

import io.ktor.application.*
import io.ktor.http.*
import io.ktor.server.testing.*
import kotlin.test.Test
import kotlin.test.assertEquals

class AppTest {
    @Test fun appHasAGreeting() = withTestApplication(Application::lydiaBackend) {
        with(handleRequest(HttpMethod.Get, "/isAlive")) {
            assertEquals("OK", response.content)
        }
    }
}
