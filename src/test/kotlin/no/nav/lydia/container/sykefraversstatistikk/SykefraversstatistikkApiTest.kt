package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.responseObject
import io.kotest.matchers.equality.shouldBeEqualToComparingFields
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.sykefraversstatistikk.api.FILTERVERDIER_PATH
import no.nav.lydia.sykefraversstatistikk.api.FilterverdierDto
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.lydia.virksomhet.brreg.VirksomhetDto
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkApiTest {
    val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    @Test
    fun `Skal kunne hente sykefraværsstatistikk for en enkelt bedrift`() {
        val orgnum = "123456789"
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnum")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<SykefraversstatistikkVirksomhetDto>()

        result.fold(
            success = { sykefraværsstatistikkVirksomhet ->
                sykefraværsstatistikkVirksomhet shouldBeEqualToComparingFields SykefraversstatistikkVirksomhetDto.dummySvar
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `Uautorisert kall mot sykefraværsstatistikkVirksomhet-endepunktet skal returnere 401`() {
        val request = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
        val (_, response, _) = request.responseString()

        response.statusCode shouldBe 401
    }

    @Test
    fun `Frontend skal kunne hente filterverdier til prioriteringssiden`() {
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<FilterverdierDto>()

        result.fold(
            success = { filterverdier ->
                filterverdier.fylker[0].fylke.navn shouldBe "Oslo"
                filterverdier.fylker[0].fylke.nummer shouldBe "03"
                filterverdier.fylker[0].kommuner.size shouldBe 1
            }, failure = {
                fail(it.message)
            })
    }

    @Test
    fun `Uautorisert kall mot filterverdi-endepunktet skal returnere 401`() {
        val request = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
        val (_, response, _) = request.responseString()

        response.statusCode shouldBe 401
    }

    @Test
    fun `Skal kunne alle organisasjoner i Viken fylke`() {
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?fylker=Viken")
            .authentication().bearer(mockOAuth2Server.lydiaApiToken)
            .responseObject<List<VirksomhetDto>>()

        result.fold(
            success = { virksomheter ->
                virksomheter.first().navn shouldBe "Brønnøy"
            }, failure = {
                fail(it.message)
            })
    }
}