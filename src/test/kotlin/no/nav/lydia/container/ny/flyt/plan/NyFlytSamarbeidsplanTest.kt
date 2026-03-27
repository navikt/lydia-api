package no.nav.lydia.container.ny.flyt.plan

import io.kotest.assertions.shouldFailWithMessage
import io.kotest.inspectors.forAll
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.shouldBe
import kotlinx.datetime.DateTimeUnit
import kotlinx.datetime.plus
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.endreTema
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.hentVirksomhetTilstand
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.oppdaterSamarbeidsplan
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeidsplan
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.slettSamarbeidsplan
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.PlanHelper.Companion.SLUTT_DATO
import no.nav.lydia.helper.PlanHelper.Companion.START_DATO
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.plan.PlanMedPubliseringStatusDto
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitetDto
import org.junit.AfterClass
import org.junit.BeforeClass
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
import java.util.UUID
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
    fun `endre temaer på samarbeid oppdaterer sist endret dato på plan`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid(authContainerHelper.saksbehandler1.token)
        val opprinneligPlan: PlanMedPubliseringStatusDto = samarbeid.opprettSamarbeidsplan(sak.orgnr, token = authContainerHelper.saksbehandler1.token)

        // Gjør bare en endring på sluttDato i første tema og eksluder andre tema

        val endringer = opprinneligPlan.endreTema(
            temaId = opprinneligPlan.temaer[0].id,
            inkluderTema = true,
            inkluderUnderTema = true,
            nyStartDato = START_DATO,
            nySluttDato = SLUTT_DATO.plus(15, DateTimeUnit.DAY),
        ).endreTema(
            temaId = opprinneligPlan.temaer[1].id,
            inkluderTema = false,
        ).tilRequest()

        val oppdatertSamarbeidsplan = samarbeid.oppdaterSamarbeidsplan(
            orgnr = sak.orgnr,
            planId = opprinneligPlan.id,
            endringer = endringer,
            token = authContainerHelper.saksbehandler1.token,
        )

        oppdatertSamarbeidsplan.id shouldBe opprinneligPlan.id
        oppdatertSamarbeidsplan.sistEndret shouldBeGreaterThan opprinneligPlan.sistEndret
        oppdatertSamarbeidsplan.temaer[0].undertemaer.forAll {
            it.sluttDato!! shouldBeGreaterThan SLUTT_DATO
        }
        oppdatertSamarbeidsplan.temaer[1].inkludert shouldBe false
    }

    @Test
    fun `skal ikke kunne fjerne undertemaer som har aktiviteter fra salesforce knyttet til seg`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid(authContainerHelper.saksbehandler1.token)
        val opprinneligPlan: PlanMedPubliseringStatusDto = samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, token = authContainerHelper.saksbehandler1.token)
        val førsteTema = opprinneligPlan.temaer.first()
        val førsteUndertema = førsteTema.undertemaer.first()
        førsteUndertema.inkludert shouldBe true

        val salesforceAktivitet = SalesforceAktivitetDto(
            Id__c = UUID.randomUUID().toString(),
            IACaseNumber__c = sak.saksnummer,
            IACooperationId__c = samarbeid.id.toString(),
            IAPlanId__c = opprinneligPlan.id,
            LastModifiedDate__c = ZonedDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME),
            EventType__c = "Created",
            TaskEvent__c = "Møte",
            Service__c = førsteTema.navn,
            IASubtheme__c = førsteUndertema.navn,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = salesforceAktivitet.Id__c,
            melding = Json.encodeToString(salesforceAktivitet),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )

        val endringer = opprinneligPlan.endreTema(
            temaId = opprinneligPlan.temaer[0].id,
            inkluderTema = true,
            inkluderUnderTema = false, // 👉 Det skal ikke være mulig å ekskludere undertema når det finnes aktiviteter knyttet til det
            nyStartDato = null,
            nySluttDato = null,
        ).tilRequest()

        shouldFailWithMessage("HTTP Exception 409 Conflict") {
            val plan = samarbeid.oppdaterSamarbeidsplan(
                orgnr = sak.orgnr,
                planId = opprinneligPlan.id,
                endringer = endringer,
                token = authContainerHelper.saksbehandler1.token,
            )
            plan.id shouldBe opprinneligPlan.id
        }

        // -- Send slette melding om SF aktivitet

        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = salesforceAktivitet.Id__c,
            melding = Json.encodeToString(salesforceAktivitet.copy(EventType__c = "Deleted")),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )

        val planEtterEndring = samarbeid.oppdaterSamarbeidsplan(
            orgnr = sak.orgnr,
            planId = opprinneligPlan.id,
            endringer = endringer,
            token = authContainerHelper.saksbehandler1.token,
        )

        planEtterEndring.temaer.first().undertemaer.forAll {
            it.inkludert shouldBe false
        }
    }

    @Test
    fun `Tilstand og status er uendret etter sletting av samarbeidsplan`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = hentPlanMal())
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        sak.opprettSamarbeid(samarbeidsnavn = "Helt nytt").opprettSamarbeidsplan(orgnr = sak.orgnr)

        samarbeid.slettSamarbeidsplan(orgnr = sak.orgnr)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }
}
