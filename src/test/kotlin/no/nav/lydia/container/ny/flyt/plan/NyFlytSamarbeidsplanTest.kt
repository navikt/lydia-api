package no.nav.lydia.container.ny.flyt.plan

import io.kotest.assertions.shouldFailWithMessage
import io.kotest.inspectors.forAll
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.shouldBe
import kotlinx.datetime.DateTimeUnit
import kotlinx.datetime.plus
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.abc.samarbeidsplan.PlanDto
import no.nav.lydia.abc.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.endreStatusPåUndertemaISamarbeidsplan
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.endreTema
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.hentVirksomhetTilstand
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.oppdaterSamarbeidsplan
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.oppdaterTemaISamarbeidsplan
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.slettSamarbeidsplan
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.verifiserKafkaPlanObserversErVarslet
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.PlanHelper.Companion.SLUTT_DATO
import no.nav.lydia.helper.PlanHelper.Companion.START_DATO
import no.nav.lydia.helper.PlanHelper.Companion.antallInnholdMedStatus
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.opprettSamarbeidsplan
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.abc.samarbeidsperiode.IASak
import no.nav.lydia.ia.sak.domene.plan.InnholdMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.plan.TemaMalDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitetDto
import org.junit.AfterClass
import org.junit.BeforeClass
import java.time.LocalDate.now
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

        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
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

        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        sak.opprettSamarbeid(samarbeidsnavn = "Samarbeid med ${sak.orgnr}")
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val samarbeidNummer2 = sak.opprettSamarbeid(samarbeidsnavn = "Nytt samarbeid for ${sak.orgnr}")
        val planPåSamaarbeidNummer2 = samarbeidNummer2.opprettSamarbeidsplan(sak.orgnr)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        verifiserKafkaPlanObserversErVarslet(
            iASakDto = sak,
            iASamarbeidDto = samarbeidNummer2,
            plan = planPåSamaarbeidNummer2,
        )
    }

    @Test
    fun `endre temaer på samarbeid oppdaterer sist endret dato på plan`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid(authContainerHelper.saksbehandler1.token)
        val opprinneligPlan: PlanDto = samarbeid.opprettSamarbeidsplan(sak.orgnr, token = authContainerHelper.saksbehandler1.token)

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
        verifiserKafkaPlanObserversErVarslet(
            iASakDto = sak,
            iASamarbeidDto = samarbeid,
            plan = oppdatertSamarbeidsplan,
        )
    }

    @Test
    fun `skal ikke kunne fjerne undertemaer som har aktiviteter fra salesforce knyttet til seg`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid(authContainerHelper.saksbehandler1.token)
        val opprinneligPlan: PlanDto = samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, token = authContainerHelper.saksbehandler1.token)
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
    fun `endre ett tema på samarbeid oppdaterer sist endret dato på plan og trigger kafka-eksport til BigQuery`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid(authContainerHelper.saksbehandler1.token)
        val opprinneligPlan: PlanDto = samarbeid.opprettSamarbeidsplan(sak.orgnr, token = authContainerHelper.saksbehandler1.token)

        // Gjør bare en endring på sluttDato i første tema og eksluder andre tema

        val temaId = opprinneligPlan.temaer[0].id
        val endringer = opprinneligPlan.endreTema(
            temaId = temaId,
            inkluderTema = true,
            inkluderUnderTema = true,
            nyStartDato = START_DATO,
            nySluttDato = SLUTT_DATO.plus(15, DateTimeUnit.DAY),
        ).tilRequest().first().undertemaer

        val oppdatertSamarbeidsplan = samarbeid.oppdaterTemaISamarbeidsplan(
            orgnr = sak.orgnr,
            planId = opprinneligPlan.id,
            temaId = temaId,
            endringer = endringer,
            token = authContainerHelper.saksbehandler1.token,
        )

        oppdatertSamarbeidsplan.id shouldBe opprinneligPlan.id
        oppdatertSamarbeidsplan.sistEndret shouldBeGreaterThan opprinneligPlan.sistEndret
        oppdatertSamarbeidsplan.temaer[0].undertemaer.forAll {
            it.sluttDato!! shouldBeGreaterThan SLUTT_DATO
        }

        verifiserKafkaPlanObserversErVarslet(
            iASakDto = sak,
            iASamarbeidDto = samarbeid,
            plan = oppdatertSamarbeidsplan,
        )
    }

    @Test
    fun `kan endre status på undertema i samarbeidsplan`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        val plan = samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = hentPlanMal().inkluderAlt())

        val førsteTema = plan.temaer.first()
        val førsteUndertema = førsteTema.undertemaer.first()

        val oppdatertPlan = samarbeid.endreStatusPåUndertemaISamarbeidsplan(
            orgnr = sak.orgnr,
            planId = plan.id,
            temaId = førsteTema.id,
            undertemaId = førsteUndertema.id,
            nyStatus = PlanUndertema.Status.FULLFØRT,
        )

        oppdatertPlan.antallInnholdMedStatus(status = PlanUndertema.Status.FULLFØRT) shouldBe 1

        verifiserKafkaPlanObserversErVarslet(
            iASakDto = sak,
            iASamarbeidDto = samarbeid,
            plan = oppdatertPlan,
        )
    }

    @Test
    fun `kan ikke endre status på undertema som ikke er inkludert`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        val plan = samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = hentPlanMal())

        val førsteTema = plan.temaer.first()
        val førsteUndertema = førsteTema.undertemaer.first()

        shouldFailWithMessage("HTTP Exception 400 Bad Request") {
            samarbeid.endreStatusPåUndertemaISamarbeidsplan(
                orgnr = sak.orgnr,
                planId = plan.id,
                temaId = førsteTema.id,
                undertemaId = førsteUndertema.id,
                nyStatus = PlanUndertema.Status.FULLFØRT,
            )
        }
    }

    @Test
    fun `kan ikke endre status til AVBRUTT om undertema starter i fremtiden`() {
        val iDag = now().toKotlinLocalDate()
        val iMorgen = iDag.plus(1, DateTimeUnit.DAY)
        val om6Måneder = iDag.plus(6, DateTimeUnit.MONTH)

        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        val plan = samarbeid.opprettSamarbeidsplan(
            orgnr = sak.orgnr,
            planMal = PlanMalDto(
                tema = listOf(
                    TemaMalDto(
                        rekkefølge = 1,
                        navn = "Et tema til test",
                        inkludert = true,
                        innhold = listOf(
                            InnholdMalDto(
                                rekkefølge = 1,
                                navn = "Et undertema til test",
                                inkludert = true,
                                startDato = iMorgen,
                                sluttDato = om6Måneder,
                            ),
                        ),
                    ),
                ),
            ),
        )

        val førsteTema = plan.temaer.first()
        val førsteUndertema = førsteTema.undertemaer.first()
        førsteUndertema.status shouldBe PlanUndertema.Status.PLANLAGT
        førsteUndertema.startDato shouldBe iMorgen

        shouldFailWithMessage("HTTP Exception 400 Bad Request") {
            samarbeid.endreStatusPåUndertemaISamarbeidsplan(
                orgnr = sak.orgnr,
                planId = plan.id,
                temaId = førsteTema.id,
                undertemaId = førsteUndertema.id,
                nyStatus = PlanUndertema.Status.AVBRUTT,
            )
        }
    }

    @Test
    fun `Tilstand og status er uendret etter sletting av samarbeidsplan`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        val plan = samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = hentPlanMal())
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        sak.opprettSamarbeid(samarbeidsnavn = "Helt nytt").opprettSamarbeidsplan(orgnr = sak.orgnr)

        samarbeid.slettSamarbeidsplan(orgnr = sak.orgnr, planId = plan.id)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }
}
