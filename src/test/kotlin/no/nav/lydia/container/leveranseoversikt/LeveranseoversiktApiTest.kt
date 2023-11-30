package no.nav.lydia.container.leveranseoversikt

import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.ktor.http.*
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.helper.LeveranseoversiktHelper
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.oppdaterIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.opprettIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.slettIASakLeveranse
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData.Companion.AKTIV_MODUL
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.api.IATjenesteDto
import no.nav.lydia.ia.sak.api.ModulDto
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import org.junit.After
import org.junit.Before
import org.junit.Test

class LeveranseoversiktApiTest {
    private val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer
    val saksbehandlerToken = mockOAuth2Server.saksbehandler1.token

    // lag to virksomheter og sett dei til Vi bistår
    val virksomhet1 = VirksomhetHelper.lastInnNyVirksomhet()
    val sakVirksomhet1 = SakHelper.nySakIViBistår(orgnummer = virksomhet1.orgnr, saksbehandlerToken)

    val virksomhet2 = VirksomhetHelper.lastInnNyVirksomhet()
    val sakVirksomhet2 = SakHelper.nySakIViBistår(orgnummer = virksomhet2.orgnr, saksbehandlerToken)

    // Lag leveransar på sakane
    val leveranseFristIDag = sakVirksomhet1.opprettIASakLeveranse(frist = java.time.LocalDate.now().toKotlinLocalDate(), AKTIV_MODUL.id)
    val leveranseFristOm10Dager = sakVirksomhet1.opprettIASakLeveranse(frist = java.time.LocalDate.now().plusDays(10).toKotlinLocalDate(), 16)
    val leveranseFristFor10DagerSiden = sakVirksomhet2.opprettIASakLeveranse(frist = java.time.LocalDate.now().minusDays(10).toKotlinLocalDate(), AKTIV_MODUL.id)
    val fullførtLeveranse = sakVirksomhet2.opprettIASakLeveranse(frist = java.time.LocalDate.now().toKotlinLocalDate(), 16)
        .oppdaterIASakLeveranse(virksomhet2.orgnr, IASakLeveranseStatus.LEVERT, saksbehandlerToken)

    @After
    fun ryddOppLeveranser() {
        leveranseFristIDag.slettIASakLeveranse(virksomhet1.orgnr, saksbehandlerToken)
        leveranseFristOm10Dager.slettIASakLeveranse(virksomhet1.orgnr, saksbehandlerToken)
        leveranseFristFor10DagerSiden.slettIASakLeveranse(virksomhet2.orgnr, saksbehandlerToken)
        fullførtLeveranse.slettIASakLeveranse(virksomhet2.orgnr, saksbehandlerToken)
    }

    @Test
    fun `skal kunne hente mine leveranser`() {

        // både fram og tilbake i tid
        val mineLeveranser = LeveranseoversiktHelper.hentMineLeveranser(token = saksbehandlerToken)

        mineLeveranser.second.statusCode shouldBe HttpStatusCode.OK.value
        mineLeveranser.third.get() shouldHaveAtLeastSize 3
    }

    @Test
    fun `skal ikke kunne hente leveranser som lesebruker`() {
        val lesebrukerToken = mockOAuth2Server.lesebruker.token
        val mineLeveranser = LeveranseoversiktHelper.hentMineLeveranser(token = lesebrukerToken)

        mineLeveranser.second.statusCode shouldBe HttpStatusCode.Forbidden.value
    }

    @Test
    fun `skal ikke få ut fullførte leveranser`() {
        val mineLeveranser = LeveranseoversiktHelper.hentMineLeveranser(token = saksbehandlerToken).third.get()

        mineLeveranser.forAll { it.status shouldBe IASakLeveranseStatus.UNDER_ARBEID.name }
    }

    @Test
    fun `skal få ei tom liste om du ikke har planlagte leveranser`() {
        val saksbehandler2Token = mockOAuth2Server.saksbehandler2.token
        val mineLeveranser = LeveranseoversiktHelper.hentMineLeveranser(token = saksbehandler2Token).third.get()

        mineLeveranser shouldHaveSize 0
    }

    @Test
    fun `skal kunne få ut leveranser selv om IA-tjenesten eller modulen er deaktivert`() {
        // TODO skriv test
    }

}

