package no.nav.lydia.container.ny.flyt

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NY_FLYT_PATH
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType.VIRKSOMHETEN_TAKKET_NEI
import kotlin.test.Test

class NyFlytTest {
    @Test
    fun `skal kunne vurdere samarbeid med en virksomhet`() {
        val orgnummer = VirksomhetHelper.nyttOrgnummer()
        val res = applikasjon.performPost("$NY_FLYT_PATH/$orgnummer/vurder")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<IASakDto>()

        res.second.statusCode shouldBe HttpStatusCode.Created.value
        res.third.get().status shouldBe IASak.Status.VURDERES
    }

    @Test
    fun `skal ikke kunne vurdere samarbeid med en virksomhet uten å være superbruker`() {
        val orgnummer = VirksomhetHelper.nyttOrgnummer()
        val res1 = applikasjon.performPost("$NY_FLYT_PATH/$orgnummer/vurder")
            .authentication().bearer(authContainerHelper.lesebruker.token)
            .tilSingelRespons<IASakDto>()
        res1.second.statusCode shouldBe HttpStatusCode.Forbidden.value

        val res2 = applikasjon.performPost("$NY_FLYT_PATH/$orgnummer/vurder")
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<IASakDto>()
        res2.second.statusCode shouldBe HttpStatusCode.Forbidden.value
    }

    @Test
    fun `skal kunne angre vurdering av samarbeid med en virksomhet`() {
        val orgnummer = VirksomhetHelper.nyttOrgnummer()
        val vurderRes = applikasjon.performPost("$NY_FLYT_PATH/$orgnummer/vurder")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<IASakDto>()
        vurderRes.second.statusCode shouldBe HttpStatusCode.Created.value

        val angreVurderRes = applikasjon.performPost("$NY_FLYT_PATH/$orgnummer/angre-vurdering")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<IASakDto>()
        angreVurderRes.second.statusCode shouldBe HttpStatusCode.OK.value

        val sakenErSlettet = postgresContainerHelper.hentEnkelKolonne<Boolean>(
            """
            SELECT count(*) = 0
                 FROM IA_SAK 
                 WHERE orgnr = '$orgnummer'
            """.trimIndent(),
        )
        sakenErSlettet.shouldBeTrue()
    }

    @Test
    fun `skal kunne fullføre vurdering som ikke medfører et samarbeid`() {
        val orgnummer = VirksomhetHelper.nyttOrgnummer()
        val vurderRes = applikasjon.performPost("$NY_FLYT_PATH/$orgnummer/vurder")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<IASakDto>()
        vurderRes.second.statusCode shouldBe HttpStatusCode.Created.value

        val fullførVurderingRes = applikasjon.performPost("$NY_FLYT_PATH/$orgnummer/fullfor-vurdering")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .jsonBody(
                Json.encodeToString(
                    ValgtÅrsak(
                        type = VIRKSOMHETEN_TAKKET_NEI,
                        begrunnelser = listOf(
                            VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID,
                        ),
                    ),
                ),
            )
            .tilSingelRespons<IASakDto>()
        fullførVurderingRes.second.statusCode shouldBe HttpStatusCode.OK.value
        fullførVurderingRes.third.get().status shouldBe IASak.Status.VURDERT
    }
}
