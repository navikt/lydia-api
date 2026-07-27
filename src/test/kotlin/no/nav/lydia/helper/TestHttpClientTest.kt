package no.nav.lydia.helper

import io.kotest.matchers.shouldBe
import kotlin.test.Test

class TestHttpClientTest {
    @Test
    fun `toAsciiUrl percent-encodes non-ascii query names and values`() {
        "http://localhost:8080/api?Søkeparametere=blåbær".toAsciiUrl() shouldBe
            "http://localhost:8080/api?S%C3%B8keparametere=bl%C3%A5b%C3%A6r"
    }
}
