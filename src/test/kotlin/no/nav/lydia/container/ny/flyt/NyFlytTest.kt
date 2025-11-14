package no.nav.lydia.container.ny.flyt

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NY_FLYT_PATH
import no.nav.lydia.ia.sak.domene.IASak
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
}
