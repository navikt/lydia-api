package no.nav.lydia.container.leveranseoversikt

import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.shouldBe
import io.ktor.http.*
import kotlinx.datetime.LocalDate
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.helper.LeveranseoversiktHelper
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.opprettIASakLeveranse
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestData.Companion.AKTIV_MODUL
import no.nav.lydia.helper.VirksomhetHelper
import org.junit.Test
import java.util.Date

class LeveranseoversiktApiTest {
    private val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer


    @Test
    fun `skal kunne hente mine leveranser`() {
        val saksbehandlerToken = mockOAuth2Server.saksbehandler1.token
        // lag to virksomheter og sett dei til Vi bistår
        val virksomhet1 = VirksomhetHelper.lastInnNyVirksomhet()
        val sakVirksomhet1 = SakHelper.nySakIViBistår(orgnummer = virksomhet1.orgnr)

        val virksomhet2 = VirksomhetHelper.lastInnNyVirksomhet()
        val sakVirksomhet2 = SakHelper.nySakIViBistår(orgnummer = virksomhet2.orgnr)

        // planlegg leveranser på desse
        sakVirksomhet1.opprettIASakLeveranse(frist = java.time.LocalDate.now().toKotlinLocalDate(), AKTIV_MODUL.id)
        sakVirksomhet1.opprettIASakLeveranse(frist = java.time.LocalDate.now().plusDays(10).toKotlinLocalDate(), 16)
        sakVirksomhet2.opprettIASakLeveranse(frist = java.time.LocalDate.now().minusDays(10).toKotlinLocalDate(), AKTIV_MODUL.id)

        // både fram og tilbake i tid
        val mineLeveranser = LeveranseoversiktHelper.hentMineLeveranser(token = saksbehandlerToken)

        mineLeveranser.second.statusCode shouldBe HttpStatusCode.OK.value
        mineLeveranser.third.get() shouldHaveAtLeastSize 3
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

