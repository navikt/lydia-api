package no.nav.lydia.container.ny.flyt.plan

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import kotlinx.serialization.json.Json
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.hentVirksomhetTilstand
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeidsplan
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.slettSamarbeidsplan
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.ny.flyt.NY_FLYT_API_PATH
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.plan.PlanMedPubliseringStatusDto
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class NyFlytSamarbeidsplanTest {
    companion object {
        @BeforeClass
        @JvmStatic
        fun setUp() {
            NyFlytTestUtils.setUpKonsumenter()
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            NyFlytTestUtils.tearDownKonsumenter()
        }
    }

    @Test
    fun `Opprett plan fungerer på virksomhet som er i tilstand VirksomhetHarAktiveSamarbeid`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid(authContainerHelper.saksbehandler1.token)
        val plan: PlanMalDto = hentPlanMal()

        val respons = applikasjon.performPost(
            url = "$NY_FLYT_API_PATH/virksomhet/${sak.orgnr}/samarbeidsperiode/${sak.saksnummer}/samarbeid/${samarbeid.id}/plan",
        ).jsonBody(Json.encodeToString(value = plan))
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<PlanMedPubliseringStatusDto>()
        respons.statuskode() shouldBe HttpStatusCode.OK.value
    }

    @Test
    fun `opprettelse av samarbeidsplan når virksomheten er i status VURDERES skal gjøre virksomheten AKTIV`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val plan = samarbeid.opprettSamarbeidsplan(sak.orgnr)
        plan.status shouldBe IASamarbeid.Status.AKTIV
        hentVirksomhetTilstand(sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `opprettelse av samarbeidsplan når virksomheten er i status AKTIV skal ikke endre status`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.opprettSamarbeid(samarbeidsnavn = "Samarbeid med ${sak.orgnr}").opprettSamarbeidsplan(sak.orgnr)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        sak.opprettSamarbeid(samarbeidsnavn = "Nytt samarbeid for ${sak.orgnr}").opprettSamarbeidsplan(sak.orgnr)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `Tilstand og status er uendret etter sletting av samarbeidsplan`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        sak.opprettSamarbeid(samarbeidsnavn = "Helt nytt").opprettSamarbeidsplan(orgnr = sak.orgnr)

        samarbeid.slettSamarbeidsplan(orgnr = sak.orgnr)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }
}
