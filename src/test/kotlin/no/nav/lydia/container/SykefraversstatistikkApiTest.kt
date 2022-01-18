package no.nav.lydia.container

import com.github.kittinunf.fuel.core.isSuccessful
import no.nav.lydia.container.TestContainerHelper.Companion.performGet
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import kotlin.test.Test
import kotlin.test.assertEquals

class SykefraversstatistikkApiTest {
    val lydiaApiContainer = TestContainerHelper.lydiaApiContainer()

    @Test
    fun `Spør etter sykefraversstatistikk på ett enkelt orgnummer`() {
        val orgnum = "123456789"
        val (_, response, _) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnum")
            .responseString()

        assert(response.isSuccessful)
        assertEquals("OK", response.responseMessage)
    }
}