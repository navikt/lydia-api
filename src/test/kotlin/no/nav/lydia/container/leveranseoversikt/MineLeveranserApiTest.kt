package no.nav.lydia.container.leveranseoversikt

import arrow.core.right
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.ktor.http.*
import no.nav.lydia.helper.LeveranseoversiktHelper
import no.nav.lydia.helper.TestContainerHelper
import org.junit.Test

class MineLeveranserApiTest {
    private val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    @Test
    fun `skal kunne hente mine leveranser`() {
        val saksbehandlerToken = mockOAuth2Server.saksbehandler1.token
        // lag to virksomheter


        // sett dei til Vi bistår


        // planlegg leveranser på desse


        // både fram og tilbake i tid
        val mineLeveranser = LeveranseoversiktHelper.hentMineLeveranser(token = saksbehandlerToken)

        mineLeveranser.second.statusCode shouldBe HttpStatusCode.OK
        mineLeveranser.third.get() shouldHaveAtLeastSize 1

    }

    @Test
    fun `skal ikke kunne hente leveranser som lesebruker`() {

    }

    @Test
    fun `skal ikke få ut fullførte leveranser`() {

    }

    @Test
    fun `skal få ei tom liste om du ikke har planlagte leveranser`() {

    }

    @Test
    fun `skal kunne få ut leveranser selv om IA-tjenesten eller modulen er deaktivert`() {

    }

}

