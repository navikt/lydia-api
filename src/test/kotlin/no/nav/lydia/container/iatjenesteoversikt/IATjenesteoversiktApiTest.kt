package no.nav.lydia.container.iatjenesteoversikt

import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.forNone
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.helper.IATjenesteoversiktHelper
import no.nav.lydia.helper.LeveranseHelper.Companion.deaktiverIATjeneste
import no.nav.lydia.helper.LeveranseHelper.Companion.deaktiverModul
import no.nav.lydia.helper.LeveranseHelper.Companion.leggTilIATjeneste
import no.nav.lydia.helper.LeveranseHelper.Companion.leggTilModul
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.oppdaterIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.opprettIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.slettIASakLeveranse
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestData.Companion.AKTIV_MODUL
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.api.IATjenesteDto
import no.nav.lydia.ia.sak.api.ModulDto
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import org.junit.After
import org.junit.Test

class IATjenesteoversiktApiTest {
    private val saksbehandlerToken = authContainerHelper.saksbehandler1.token

    // lag to virksomheter og sett dei til Vi bistår
    private val virksomhet1 = VirksomhetHelper.lastInnNyVirksomhet()
    private val sakVirksomhet1 = SakHelper.nySakIViBistår(orgnummer = virksomhet1.orgnr, saksbehandlerToken)

    private val virksomhet2 = VirksomhetHelper.lastInnNyVirksomhet()
    private val sakVirksomhet2 = SakHelper.nySakIViBistår(orgnummer = virksomhet2.orgnr, saksbehandlerToken)

    // Lag leveransar på sakane
    private val leveranseFristIDag = sakVirksomhet1.opprettIASakLeveranse(
        frist = java.time.LocalDate.now().toKotlinLocalDate(),
        AKTIV_MODUL.id,
    )
    private val leveranseFristOm10Dager = sakVirksomhet1.opprettIASakLeveranse(
        frist = java.time.LocalDate.now().plusDays(10).toKotlinLocalDate(),
        16,
    )
    private val leveranseFristFor10DagerSiden = sakVirksomhet2.opprettIASakLeveranse(
        frist = java.time.LocalDate.now().minusDays(10).toKotlinLocalDate(),
        AKTIV_MODUL.id,
    )
    private val fullførtLeveranse = sakVirksomhet2.opprettIASakLeveranse(
        frist = java.time.LocalDate.now().toKotlinLocalDate(),
        16,
    )
        .oppdaterIASakLeveranse(
            orgnr = virksomhet2.orgnr,
            status = IASakLeveranseStatus.LEVERT,
            token = saksbehandlerToken,
        )

    @After
    fun ryddOppLeveranser() {
        leveranseFristIDag.slettIASakLeveranse(virksomhet1.orgnr, saksbehandlerToken)
        leveranseFristOm10Dager.slettIASakLeveranse(virksomhet1.orgnr, saksbehandlerToken)
        leveranseFristFor10DagerSiden.slettIASakLeveranse(virksomhet2.orgnr, saksbehandlerToken)
        fullførtLeveranse.slettIASakLeveranse(virksomhet2.orgnr, saksbehandlerToken)
    }

    @Test
    fun `skal kunne hente mine IA-tjenester`() {
        // både fram og tilbake i tid
        val mineLeveranser = IATjenesteoversiktHelper.hentMineIATjenester(token = saksbehandlerToken)

        mineLeveranser.second.statusCode shouldBe HttpStatusCode.OK.value
        mineLeveranser.third.get() shouldHaveAtLeastSize 3
    }

    @Test
    fun `skal ikke kunne hente ia-tjenester som lesebruker`() {
        val lesebrukerToken = authContainerHelper.lesebruker.token
        val mineLeveranser = IATjenesteoversiktHelper.hentMineIATjenester(token = lesebrukerToken)

        mineLeveranser.second.statusCode shouldBe HttpStatusCode.Forbidden.value
    }

    @Test
    fun `skal ikke få ut fullførte ia-tjenester`() {
        val mineLeveranser = IATjenesteoversiktHelper.hentMineIATjenester(token = saksbehandlerToken).third.get()

        mineLeveranser.forAll { it.status shouldBe IASakLeveranseStatus.UNDER_ARBEID.name }
    }

    @Test
    fun `skal få ei tom liste om du ikke har planlagte ia-tjenester`() {
        val saksbehandler2Token = authContainerHelper.saksbehandler2.token
        val mineLeveranser = IATjenesteoversiktHelper.hentMineIATjenester(token = saksbehandler2Token).third.get()

        mineLeveranser shouldHaveSize 0
    }

    @Test
    fun `skal kunne få ut ia-tjenester selv om IA-tjenesten eller modulen er deaktivert`() {
        // Lagar ia-teneste og modul som skal deaktiverast
        val iaTjeneste = IATjenesteDto(id = 5001, navn = "Test", deaktivert = false)
        val modul = ModulDto(id = 5001, navn = "Test", iaTjeneste = iaTjeneste.id, deaktivert = false)

        leggTilIATjeneste(iaTjeneste = iaTjeneste)
        leggTilModul(modul = modul)

        // Lagar sak og opprettar ein ia-tjeneste med den nylaga ia-tenesten og modulen
        val sak = SakHelper.nySakIViBistår(token = saksbehandlerToken)
        sak.opprettIASakLeveranse(modulId = modul.id, token = saksbehandlerToken)

        // Deaktiverar modul og teneste
        deaktiverModul(modul = modul)
        deaktiverIATjeneste(iaTjeneste = iaTjeneste)

        // Hentar ut mine ia-tjenester
        val mineLeveranser = IATjenesteoversiktHelper.hentMineIATjenester(token = saksbehandlerToken).third.get()

        mineLeveranser shouldHaveAtLeastSize 1
        mineLeveranser.forAtLeastOne { it.modul.deaktivert && it.iaTjeneste.deaktivert }
        mineLeveranser.forAtLeastOne { it.iaTjeneste.id == iaTjeneste.id && it.modul.id == modul.id }
    }

    @Test
    fun `skal ikke få ut leveranser i saker som er avsluttet`() {
        val virksomhet1 = VirksomhetHelper.lastInnNyVirksomhet()
        val leveranseIAvsluttetSak =
            SakHelper.nySakIViBistår(orgnummer = virksomhet1.orgnr).opprettIASakLeveranse(modulId = AKTIV_MODUL.id)
        postgresContainerHelper.performUpdate(
            "UPDATE ia_sak SET status = 'FULLFØRT' WHERE saksnummer = '${leveranseIAvsluttetSak.saksnummer}'",
        )

        val virksomhet2 = VirksomhetHelper.lastInnNyVirksomhet()
        val leveranseIÅpenSak =
            SakHelper.nySakIViBistår(orgnummer = virksomhet2.orgnr).opprettIASakLeveranse(modulId = AKTIV_MODUL.id)
        val mineleveranser = IATjenesteoversiktHelper.hentMineIATjenester().third.get()
        mineleveranser.forAtLeastOne {
            it.orgnr shouldBe virksomhet2.orgnr
        }
        mineleveranser.forNone {
            it.orgnr shouldBe virksomhet1.orgnr
        }

        // rydd opp
        postgresContainerHelper.performUpdate(
            "delete from iasak_leveranse where saksnummer = '${leveranseIAvsluttetSak.saksnummer}'",
        )
        leveranseIÅpenSak.slettIASakLeveranse(virksomhet2.orgnr, saksbehandlerToken)
    }
}
