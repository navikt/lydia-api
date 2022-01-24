package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.responseObject
import io.kotest.matchers.shouldBe
import no.nav.lydia.container.helper.TestContainerHelper
import no.nav.lydia.container.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.sykefraversstatistikk.api.FILTERVERDIER_PATH
import no.nav.lydia.sykefraversstatistikk.api.FilterverdierDto
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkApiTest {
    val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    @Test
    fun `Spør etter sykefraversstatistikk på ett enkelt orgnummer`() {
        val orgnum = "123456789"
        val (_, response, _) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnum")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseString()

        response.statusCode shouldBe 200
        response.responseMessage shouldBe "OK"
    }

    @Test
    fun `Frontend skal kunne hente filterverdier til prioriteringssiden`() {
        val (_, response, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<FilterverdierDto>()

        response.statusCode shouldBe 200
        result.fold(
            success = { filterverdier ->
                filterverdier.fylker[0].navn shouldBe "Innlandet"
                filterverdier.fylker[0].kommuner[0].navn shouldBe "Alvdal"
            }, failure = {
                fail("")
            })
    }

    @Test
    fun `Uautorisert kall mot beskyttet endepunkt skal returnere 401`() {
        val request = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
        val (_, response, _) = request.responseString()

        response.statusCode shouldBe 401
    }
}