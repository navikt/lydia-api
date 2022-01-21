package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.core.isSuccessful
import com.github.kittinunf.fuel.gson.responseObject
import no.nav.lydia.container.helper.TestContainerHelper
import no.nav.lydia.container.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.sykefraversstatistikk.api.FILTERVERDIER_PATH
import no.nav.lydia.sykefraversstatistikk.api.FilterverdierDto
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertIs
import kotlin.test.fail

class SykefraversstatistikkApiTest {
    val lydiaApiContainer = TestContainerHelper.lydiaApiContainer()

    @Test
    fun `Spør etter sykefraversstatistikk på ett enkelt orgnummer`() {
        val orgnum = "123456789"
        val (_, response, _) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnum").responseString()

        assert(response.isSuccessful)
        assertEquals("OK", response.responseMessage)
    }

    @Test
    fun `Frontend skal kunne hente filterverdier til prioriteringssiden`() {
        val (_, response, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
            .responseObject<FilterverdierDto>()

        assert(response.isSuccessful)
        result.fold(success = {
            assertEquals("Innlandet", it.fylker[0].navn)
            assertEquals("Alvdal", it.fylker[0].kommuner[0].navn)
        }, failure = {
            fail("")
        })
    }

    @Test
    fun `Uautorisert kall mot beskyttet endepunkt skal returnere 401`() {
        val (_, response, _) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/protected").responseString()

        assertEquals(401, response.statusCode)
    }
}