package no.nav.lydia.container.ia.sak.prosess

import com.github.kittinunf.fuel.core.extensions.authentication
import ia.felles.integrasjoner.kafkameldinger.eksport.InnholdStatus
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldContainExactlyInAnyOrder
import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.comparables.shouldBeLessThan
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettEvaluering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.PlanHelper.Companion.endreFlereTemaerIPlan
import no.nav.lydia.helper.PlanHelper.Companion.endreStatusPåInnholdIPlan
import no.nav.lydia.helper.PlanHelper.Companion.hentPlan
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.fullførSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikk
import no.nav.lydia.helper.SakHelper.Companion.kanFullføreSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.kanGjennomføreStatusendring
import no.nav.lydia.helper.SakHelper.Companion.kanSletteSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.SakHelper.Companion.slettSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performDelete
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.nyttNavnPåSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.eksport.SamarbeidsplanKafkaMelding
import no.nav.lydia.ia.sak.IAProsessService.StatusendringBegrunnelser
import no.nav.lydia.ia.sak.MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SPØRREUNDERSØKELSE_BASE_ROUTE
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitetDto
import org.junit.AfterClass
import org.junit.BeforeClass
import java.sql.Timestamp
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
import java.util.UUID
import kotlin.test.Test

class IASakProsessTest {
    companion object {
        private val topic = Topic.SAMARBEIDSPLAN_TOPIC
        private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = topic.konsumentGruppe)

        @BeforeClass
        @JvmStatic
        fun setUp() = konsument.subscribe(mutableListOf(topic.navn))

        @AfterClass
        @JvmStatic
        fun tearDown() {
            konsument.unsubscribe()
            konsument.close()
        }
    }

    @Test
    fun `skal kunne fullføre et samarbeid`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())

        sak.fullførSamarbeid(samarbeid)
        postgresContainerHelper.hentEnkelKolonne<String>(
            "SELECT status FROM ia_prosess WHERE id = ${samarbeid.id}",
        ) shouldBe no.nav.lydia.ia.sak.domene.prosess.IAProsessStatus.FULLFØRT.name
    }

    @Test
    fun `fullførte samarbeid skal ikke vises i listen over aktive samarbeid`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())

        sak.fullførSamarbeid(samarbeid)
        sak.hentAlleSamarbeid() shouldHaveSize 0
    }

    @Test
    fun `skal kunne starte nytt samarbeid etter å ha fullført et samarbeid`() {
        var sak = nySakIViBistår()
        val samarbeidSomFullføres = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())

        sak = sak.fullførSamarbeid(samarbeidSomFullføres)
        sak = sak.opprettNyttSamarbeid(navn = "Det andre samarbeid")
        sak.hentAlleSamarbeid().map { it.navn } shouldBe listOf("Det andre samarbeid")
    }

    @Test
    fun `skal kunne gå frem og tilbake i saksgang selv med fullført samarbeid`() {
        var sak = nySakIViBistår()
        val samarbeidSomFullføres = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())

        sak = sak.fullførSamarbeid(samarbeidSomFullføres)
        sak = sak.nyHendelse(IASakshendelseType.TILBAKE)
        sak = sak.nyHendelse(IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS)
        sak = sak.nyHendelse(IASakshendelseType.FULLFØR_BISTAND)
        sak.status shouldBe IAProsessStatus.FULLFØRT
    }

    @Test
    fun `skal fullføre alle inkluderte undertemaer i plan når samarbeid fullføres`() {
        var sak = nySakIViBistår()
        val samarbeidSomFullføres = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())
        sak = sak.fullførSamarbeid(samarbeidSomFullføres)
        val plan = sak.hentPlan(prosessId = samarbeidSomFullføres.id)
        plan.temaer.forAll { tema ->
            tema.undertemaer.forAll { undertema ->
                undertema.status shouldBe InnholdStatus.FULLFØRT
            }
        }
    }

    @Test
    fun `skal ikke fullføre avbrutte undertemaer når samarbeid fullføres`() {
        var sak = nySakIViBistår()
        val samarbeidSomFullføres = sak.hentAlleSamarbeid().first()
        val plan = sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())
        val tema = plan.temaer.first()
        val undertema = tema.undertemaer.first()
        sak.endreStatusPåInnholdIPlan(
            temaId = tema.id,
            innholdId = undertema.id,
            status = InnholdStatus.AVBRUTT,
        )
        sak = sak.fullførSamarbeid(samarbeidSomFullføres)
        val planEtterFullføring = sak.hentPlan(prosessId = samarbeidSomFullføres.id)
        planEtterFullføring.temaer.flatMap { it.undertemaer }.forExactlyOne {
            it.status shouldBe InnholdStatus.AVBRUTT
        }
    }

    @Test
    fun `skal få riktig historikk for saken etter fullført samarbeid`() {
        var sak = nySakIViBistår()
        val samarbeidSomFullføres = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())

        sak = sak.fullførSamarbeid(samarbeidSomFullføres)
        val historikk = hentSamarbeidshistorikk(sak.orgnr)
        historikk.forExactlyOne {
            it.sakshendelser.map { it.hendelsestype } shouldContainInOrder listOf(
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS,
                IASakshendelseType.FULLFØR_PROSESS,
            )
        }
    }

    @Test
    fun `skal få riktige begrunnelser for om et samarbeid kan fullføres (NY)`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val manglerPlan = sak.kanGjennomføreStatusendring(samarbeid, "fullfores")
        manglerPlan.kanGjennomføres shouldBe false
        manglerPlan.blokkerende shouldBe listOf(StatusendringBegrunnelser.INGEN_PLAN)
        manglerPlan.advarsler shouldBe listOf(StatusendringBegrunnelser.INGEN_EVALUERING)

        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())
        val kanFullføres = sak.kanGjennomføreStatusendring(samarbeid, "fullfores")
        kanFullføres.kanGjennomføres shouldBe true
        kanFullføres.advarsler shouldBe listOf(
            StatusendringBegrunnelser.INGEN_EVALUERING,
        )

        val evaluering = sak.opprettEvaluering()
        val aktivEvaluering = sak.kanGjennomføreStatusendring(samarbeid, "fullfores")
        aktivEvaluering.kanGjennomføres shouldBe false
        aktivEvaluering.blokkerende shouldBe listOf(
            StatusendringBegrunnelser.AKTIV_EVALUERING,
        )

        evaluering
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val kanFullføresUtenAdvarsler = sak.kanGjennomføreStatusendring(samarbeid, "fullfores")
        kanFullføresUtenAdvarsler.kanGjennomføres shouldBe true
        kanFullføresUtenAdvarsler.advarsler shouldHaveSize 0
        kanFullføresUtenAdvarsler.blokkerende shouldHaveSize 0
    }

    @Test
    fun `skal få riktige begrunnelser for om et samarbeid kan fullføres (GAMMEL)`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val manglerPlan = sak.kanFullføreSamarbeid(samarbeid)
        manglerPlan.kanFullføres shouldBe false
        manglerPlan.begrunnelser shouldContainExactlyInAnyOrder listOf(
            StatusendringBegrunnelser.INGEN_PLAN,
            StatusendringBegrunnelser.INGEN_EVALUERING,
        )

        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())
        val kanFullføres = sak.kanFullføreSamarbeid(samarbeid)
        kanFullføres.kanFullføres shouldBe true
        kanFullføres.begrunnelser shouldBe listOf(
            StatusendringBegrunnelser.INGEN_EVALUERING,
        )

        val evaluering = sak.opprettEvaluering()
        val aktivEvaluering = sak.kanFullføreSamarbeid(samarbeid)
        aktivEvaluering.kanFullføres shouldBe false
        aktivEvaluering.begrunnelser shouldBe listOf(
            StatusendringBegrunnelser.AKTIV_EVALUERING,
        )

        evaluering
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val kanFullføresUtenAdvarsler = sak.kanFullføreSamarbeid(samarbeid)
        kanFullføresUtenAdvarsler.kanFullføres shouldBe true
        kanFullføresUtenAdvarsler.begrunnelser shouldHaveSize 0
    }

    @Test
    fun `skal få riktige begrunnelser for om et samarbeid kan slettes (NY)`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val skalKunneSlettes = sak.kanGjennomføreStatusendring(samarbeid, "slettes")
        skalKunneSlettes.kanGjennomføres shouldBe true
        skalKunneSlettes.blokkerende shouldHaveSize 0

        val behovsvurdering = sak.opprettSpørreundersøkelse(type = "Behovsvurdering")
        val skalIkkeKunneSlettesPgaBehovsVurdering = sak.kanGjennomføreStatusendring(samarbeid, "slettes")
        skalIkkeKunneSlettesPgaBehovsVurdering.kanGjennomføres shouldBe false
        skalIkkeKunneSlettesPgaBehovsVurdering.blokkerende shouldBe listOf(StatusendringBegrunnelser.FINNES_BEHOVSVURDERING)

        applikasjon.performDelete("$SPØRREUNDERSØKELSE_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${behovsvurdering.id}")
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<SpørreundersøkelseDto>()
        val skalKunneSlettesIgjen = sak.kanGjennomføreStatusendring(samarbeid, "slettes")
        skalKunneSlettesIgjen.kanGjennomføres shouldBe true
        skalKunneSlettesIgjen.blokkerende shouldHaveSize 0

        val salesforceAktivitet = SalesforceAktivitetDto(
            Id__c = UUID.randomUUID().toString(),
            IACaseNumber__c = sak.saksnummer,
            IACooperationId__c = samarbeid.id.toString(),
            LastModifiedDate__c = ZonedDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME),
            EventType__c = "Created",
            TaskEvent__c = "Møte",
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = salesforceAktivitet.Id__c,
            melding = Json.encodeToString(salesforceAktivitet),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        val skalIkkeKunneSlettesPgaSfAktivitet = sak.kanGjennomføreStatusendring(samarbeid, "slettes")
        skalIkkeKunneSlettesPgaSfAktivitet.kanGjennomføres shouldBe false
        skalIkkeKunneSlettesPgaSfAktivitet.blokkerende shouldBe listOf(StatusendringBegrunnelser.FINNES_SALESFORCE_AKTIVITET)

        sak.opprettEnPlan()
        val skalIallfallIkkeKunneSlettes = sak.kanGjennomføreStatusendring(samarbeid, "slettes")
        skalIallfallIkkeKunneSlettes.kanGjennomføres shouldBe false
        skalIallfallIkkeKunneSlettes.blokkerende shouldContainExactlyInAnyOrder listOf(
            StatusendringBegrunnelser.FINNES_SALESFORCE_AKTIVITET,
            StatusendringBegrunnelser.FINNES_SAMARBEIDSPLAN,
        )
    }

    @Test
    fun `skal få riktige begrunnelser for om et samarbeid kan slettes (GAMMEL)`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val skalKunneSlettes = sak.kanSletteSamarbeid(samarbeid)
        skalKunneSlettes.kanSlettes shouldBe true
        skalKunneSlettes.begrunnelser shouldHaveSize 0

        val behovsvurdering = sak.opprettSpørreundersøkelse(type = "Behovsvurdering")
        val skalIkkeKunneSlettesPgaBehovsVurdering = sak.kanSletteSamarbeid(samarbeid)
        skalIkkeKunneSlettesPgaBehovsVurdering.kanSlettes shouldBe false
        skalIkkeKunneSlettesPgaBehovsVurdering.begrunnelser shouldBe listOf(StatusendringBegrunnelser.FINNES_BEHOVSVURDERING)

        applikasjon.performDelete("$SPØRREUNDERSØKELSE_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${behovsvurdering.id}")
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<SpørreundersøkelseDto>()
        val skalKunneSlettesIgjen = sak.kanSletteSamarbeid(samarbeid)
        skalKunneSlettesIgjen.kanSlettes shouldBe true
        skalKunneSlettesIgjen.begrunnelser shouldHaveSize 0

        val salesforceAktivitet = SalesforceAktivitetDto(
            Id__c = UUID.randomUUID().toString(),
            IACaseNumber__c = sak.saksnummer,
            IACooperationId__c = samarbeid.id.toString(),
            LastModifiedDate__c = ZonedDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME),
            EventType__c = "Created",
            TaskEvent__c = "Møte",
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = salesforceAktivitet.Id__c,
            melding = Json.encodeToString(salesforceAktivitet),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        val skalIkkeKunneSlettesPgaSfAktivitet = sak.kanSletteSamarbeid(samarbeid)
        skalIkkeKunneSlettesPgaSfAktivitet.kanSlettes shouldBe false
        skalIkkeKunneSlettesPgaSfAktivitet.begrunnelser shouldBe listOf(StatusendringBegrunnelser.FINNES_SALESFORCE_AKTIVITET)

        sak.opprettEnPlan()
        val skalIallfallIkkeKunneSlettes = sak.kanSletteSamarbeid(samarbeid)
        skalIallfallIkkeKunneSlettes.kanSlettes shouldBe false
        skalIallfallIkkeKunneSlettes.begrunnelser shouldContainExactlyInAnyOrder listOf(
            StatusendringBegrunnelser.FINNES_SALESFORCE_AKTIVITET,
            StatusendringBegrunnelser.FINNES_SAMARBEIDSPLAN,
        )
    }

    @Test
    fun `endring på samarbeid oppdaterer sistEndret`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()

        sak.nyttNavnPåSamarbeid(samarbeid, "Første")
            .nyttNavnPåSamarbeid(samarbeid, "Andre")
            .nyttNavnPåSamarbeid(samarbeid, "Tredje")

        val samarbeidMedNyttNavn = sak.hentAlleSamarbeid().first()

        samarbeidMedNyttNavn.navn shouldBe "Tredje"
        samarbeid.opprettet shouldBe samarbeidMedNyttNavn.opprettet
        samarbeid.sistEndret!! shouldBeLessThan samarbeidMedNyttNavn.sistEndret!!
    }

    @Test
    fun `tomme samarbeidsnavn skal lagres som NULL i databasen`() {
        val sak = nySakIKartleggesMedEtSamarbeid(
            navnPåSamarbeid = "",
        )

        val samarbeid = sak.hentAlleSamarbeid().first()
        postgresContainerHelper.hentEnkelKolonne<String?>(
            """
            select navn from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        ) shouldBe null

        sak.nyttNavnPåSamarbeid(samarbeid, " ")
        postgresContainerHelper.hentEnkelKolonne<String?>(
            """
            select navn from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        ) shouldBe null
    }

    @Test
    fun `oppdater endret_tidspunkt i DB ved endring av samarbeidsnavn`() {
        val sak = nySakIKartleggesMedEtSamarbeid(navnPåSamarbeid = "Avdeling 1")
        val samarbeid = sak.hentAlleSamarbeid().first()

        val endretTidspunktVedOpprettelse = postgresContainerHelper.hentEnkelKolonne<Timestamp?>(
            """
            select endret_tidspunkt from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        )?.toLocalDateTime()
        endretTidspunktVedOpprettelse shouldNotBe null

        sak.nyttNavnPåSamarbeid(samarbeid, "Avdeling 1 - Fysio")
        val endretTidspunktEtterUpdate = postgresContainerHelper.hentEnkelKolonne<Timestamp?>(
            """
            select endret_tidspunkt from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        )?.toLocalDateTime()

        endretTidspunktEtterUpdate!!.shouldBeGreaterThan(endretTidspunktVedOpprettelse!!)
    }

    @Test
    fun `oppdater endret_tidspunkt i DB ved sletting av samarbeid`() {
        val sak = nySakIKartleggesMedEtSamarbeid(navnPåSamarbeid = "Avdeling 1")
        val samarbeid = sak.hentAlleSamarbeid().first()

        val endretTidspunktVedOpprettelse = postgresContainerHelper.hentEnkelKolonne<Timestamp?>(
            """
            select endret_tidspunkt from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        )?.toLocalDateTime()
        endretTidspunktVedOpprettelse shouldNotBe null

        sak.slettSamarbeid(samarbeid)
        val endretTidspunktEtterSlett = postgresContainerHelper.hentEnkelKolonne<Timestamp?>(
            """
            select endret_tidspunkt from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        )?.toLocalDateTime()

        endretTidspunktEtterSlett!!.shouldBeGreaterThan(endretTidspunktVedOpprettelse!!)
    }

    @Test
    fun `skal beholde tildelt prosess selvom man går frem og TILBAKE i saksgang`() {
        val sakIKartlegges = nySakIKartleggesMedEtSamarbeid()
        val alleSamarbeid = sakIKartlegges.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1

        val førsteSamarbeid = alleSamarbeid.first()

        val sakIKartleggesTilbakeOgFrem = sakIKartlegges
            .nyHendelse(hendelsestype = IASakshendelseType.TILBAKE)
            .nyHendelse(hendelsestype = IASakshendelseType.VIRKSOMHET_KARTLEGGES)
        val alleSamarbeidEtterStatusEndring = sakIKartleggesTilbakeOgFrem.hentAlleSamarbeid()
        alleSamarbeidEtterStatusEndring shouldHaveSize 1

        alleSamarbeidEtterStatusEndring.first() shouldBe førsteSamarbeid
    }

    @Test
    fun `skal kunne opprette flere prosesser på samme sak`() {
        val sakIKartlegges = nySakIKartleggesMedEtSamarbeid()
        sakIKartlegges.hentAlleSamarbeid() shouldHaveSize 1
        sakIKartlegges.opprettNyttSamarbeid(navn = "Annet samarbeidsnavn").hentAlleSamarbeid() shouldHaveSize 2
    }

    @Test
    fun `skal kunne opprette kartlegginger på saker der det er flere prosesser`() {
        val sakMedEttSamarbeid = nySakIKartleggesMedEtSamarbeid()
        sakMedEttSamarbeid.hentAlleSamarbeid() shouldHaveSize 1

        val sakMedFlereSamarbeid = sakMedEttSamarbeid.opprettNyttSamarbeid(navn = "Annet samarbeidsnavn")
        sakMedFlereSamarbeid.hentAlleSamarbeid() shouldHaveSize 2

        val behovsvurdering = sakMedFlereSamarbeid.opprettSpørreundersøkelse()
        behovsvurdering.status shouldBe SpørreundersøkelseStatus.OPPRETTET
    }

    @Test
    fun `skal sende plan ved opprettelse av en ny plan på kafka`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1

        val førsteSamarbeid = alleSamarbeid.first()
        val opprettetPlan = sak.opprettEnPlan()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak.saksnummer}-${førsteSamarbeid.id}-${opprettetPlan.id}",
                konsument = konsument,
            ) {
                it.forExactlyOne { melding ->
                    val planTilSalesforce = Json.decodeFromString<SamarbeidsplanKafkaMelding>(melding)
                    planTilSalesforce.orgnr shouldBe sak.orgnr
                    planTilSalesforce.saksnummer shouldBe sak.saksnummer
                    planTilSalesforce.samarbeid.id shouldBe førsteSamarbeid.id
                    planTilSalesforce.samarbeid.navn shouldBe førsteSamarbeid.navn
                    planTilSalesforce.samarbeid.status shouldBe førsteSamarbeid.status
                    planTilSalesforce.samarbeid.endretTidspunkt shouldNotBe null
                    planTilSalesforce.plan.id shouldBe opprettetPlan.id
                    planTilSalesforce.plan.temaer.size shouldBeExactly opprettetPlan.temaer.size
                    planTilSalesforce.plan.sistEndret shouldBeGreaterThan opprettetPlan.sistEndret
                }
            }
        }
    }

    @Test
    fun `skal sende plan ved endringer i plan på kafka`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val førsteSamarbeid = sak.hentAlleSamarbeid().first()
        val opprettetPlan = sak.opprettEnPlan()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak.saksnummer}-${førsteSamarbeid.id}-${opprettetPlan.id}",
                konsument = konsument,
            ) {
                it.size shouldBe 1
            }
        }
        sak.endreFlereTemaerIPlan(endring = opprettetPlan.inkluderAlt().tilRequest())

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak.saksnummer}-${førsteSamarbeid.id}-${opprettetPlan.id}",
                konsument = konsument,
            ) {
                it.forExactlyOne { melding ->
                    val planTilSalesforce = Json.decodeFromString<SamarbeidsplanKafkaMelding>(melding)
                    planTilSalesforce.orgnr shouldBe sak.orgnr
                    planTilSalesforce.saksnummer shouldBe sak.saksnummer
                    planTilSalesforce.samarbeid.id shouldBe førsteSamarbeid.id
                    planTilSalesforce.samarbeid.navn shouldBe førsteSamarbeid.navn
                    planTilSalesforce.samarbeid.status shouldBe førsteSamarbeid.status
                    planTilSalesforce.samarbeid.endretTidspunkt shouldNotBe null
                    planTilSalesforce.plan.id shouldBe opprettetPlan.id
                    planTilSalesforce.plan.temaer.size shouldBeExactly opprettetPlan.temaer.size
                    planTilSalesforce.plan.sistEndret shouldBeGreaterThan opprettetPlan.sistEndret
                }
            }
        }
    }

    @Test
    fun `skal kunne hente ut alle aktive prosesser i en sak`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1
        alleSamarbeid.first().saksnummer shouldBe sak.saksnummer
    }

    @Test
    fun `skal ikke få feil i historikken dersom man endrer navn på prosess flere ganger`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1

        val førsteSamarbeid = alleSamarbeid.first()
        sak.nyttNavnPåSamarbeid(førsteSamarbeid, "Første")
            .nyttNavnPåSamarbeid(førsteSamarbeid, "Andre")
            .nyttNavnPåSamarbeid(førsteSamarbeid, "Tredje")
            .hentAlleSamarbeid().first().navn shouldBe "Tredje"

        val samarbeidshistorikk = hentSamarbeidshistorikk(
            sak.orgnr,
        )
        samarbeidshistorikk shouldHaveSize 1
        val sakshendelser = samarbeidshistorikk.first().sakshendelser
        sakshendelser shouldHaveSize 9
        sakshendelser.map { it.hendelsestype } shouldBe listOf(
            IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
            IASakshendelseType.VIRKSOMHET_VURDERES,
            IASakshendelseType.TA_EIERSKAP_I_SAK,
            IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
            IASakshendelseType.VIRKSOMHET_KARTLEGGES,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.ENDRE_PROSESS,
            IASakshendelseType.ENDRE_PROSESS,
            IASakshendelseType.ENDRE_PROSESS,
        )
        sakshendelser.last().status shouldBe IAProsessStatus.KARTLEGGES
    }

    @Test
    fun `skal ikke få feil i sakshistorikk dersom man sletter flere samarbeid på rad`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid(navn = "First")
            .opprettNyttSamarbeid(navn = "Sist")

        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2

        sak.slettSamarbeid(alleSamarbeid.first()).slettSamarbeid(alleSamarbeid.last())
        sak.hentAlleSamarbeid() shouldHaveSize 0

        val samarbeidshistorikk = hentSamarbeidshistorikk(
            sak.orgnr,
        )
        samarbeidshistorikk shouldHaveSize 1
        val sakshendelser = samarbeidshistorikk.first().sakshendelser
        sakshendelser shouldHaveSize 9
        sakshendelser.map { it.hendelsestype } shouldBe listOf(
            IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
            IASakshendelseType.VIRKSOMHET_VURDERES,
            IASakshendelseType.TA_EIERSKAP_I_SAK,
            IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
            IASakshendelseType.VIRKSOMHET_KARTLEGGES,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.SLETT_PROSESS,
            IASakshendelseType.SLETT_PROSESS,
        )
        sakshendelser.last().status shouldBe IAProsessStatus.KARTLEGGES
    }

    @Test
    fun `skal ikke få feil i historikken dersom man oppretter flere prosesser på rad`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        sak.hentAlleSamarbeid() shouldHaveSize 1

        sak.opprettNyttSamarbeid(navn = "Navn 1")
            .opprettNyttSamarbeid(navn = "Navn 2")
            .opprettNyttSamarbeid(navn = "Navn 3")
            .hentAlleSamarbeid() shouldHaveSize 4

        sak.hentAlleSamarbeid() shouldHaveSize 4

        val samarbeidshistorikk = hentSamarbeidshistorikk(
            sak.orgnr,
        )
        samarbeidshistorikk shouldHaveSize 1
        val sakshendelser = samarbeidshistorikk.first().sakshendelser
        sakshendelser shouldHaveSize 9
        sakshendelser.map { it.hendelsestype } shouldBe listOf(
            IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
            IASakshendelseType.VIRKSOMHET_VURDERES,
            IASakshendelseType.TA_EIERSKAP_I_SAK,
            IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
            IASakshendelseType.VIRKSOMHET_KARTLEGGES,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.NY_PROSESS,
        )
        sakshendelser.last().status shouldBe IAProsessStatus.KARTLEGGES
    }

    @Test
    fun `skal kunne slette tomme prosesser`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid()
        val samarbeidFørSletting = sak.hentAlleSamarbeid()
        samarbeidFørSletting shouldHaveSize 1

        val samarbeidSomSkalSlettes = samarbeidFørSletting.first()
        sak.slettSamarbeid(samarbeidSomSkalSlettes)

        val samarbeidEtterSletting = sak.hentAlleSamarbeid()
        samarbeidEtterSletting shouldBe emptyList()
    }

    @Test
    fun `skal ikke kunne slette prosesser som har en behovsvurdering knyttet til seg`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid()
        val alleSamarbeidFørSletting = sak.hentAlleSamarbeid()
        val samarbeidSomSkalSlettes = alleSamarbeidFørSletting.first()
        sak.opprettSpørreundersøkelse(prosessId = samarbeidSomSkalSlettes.id)
        shouldFail {
            sak.slettSamarbeid(samarbeidSomSkalSlettes)
        }
        sak.hentAlleSamarbeid() shouldBe alleSamarbeidFørSletting
    }

    @Test
    fun `skal ikke kunne slette prosesser som har en plan knyttet til seg`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid()
        val alleSamarbeidFørSletting = sak.hentAlleSamarbeid()
        val førsteSamarbeid = alleSamarbeidFørSletting.first()
        sak.opprettEnPlan()

        shouldFail {
            sak.slettSamarbeid(samarbeid = førsteSamarbeid)
        }
        sak.hentAlleSamarbeid() shouldBe alleSamarbeidFørSletting
    }

    @Test
    fun `skal få feilmelding dersom man sender inn feil data ved sletting`() {
        val sak = nySakIKartlegges()

        shouldFail {
            sak.nyHendelse(
                hendelsestype = IASakshendelseType.SLETT_PROSESS,
                payload = Json.encodeToString(
                    IAProsessDto(
                        id = 1010000,
                        saksnummer = sak.saksnummer,
                    ),
                ),
            )
        }
    }

    @Test
    fun `skal ikke lagre SLETT_PROSESS hendelse dersom sletting ikke er lov`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid()
        samarbeid shouldHaveSize 1

        sak.opprettSpørreundersøkelse()

        shouldFail {
            sak.nyHendelse(
                hendelsestype = IASakshendelseType.SLETT_PROSESS,
                payload = Json.encodeToString(
                    IAProsessDto(
                        id = 1010000,
                        saksnummer = sak.saksnummer,
                    ),
                ),
            )
        }

        val samarbeidEtterSlett = sak.hentAlleSamarbeid()
        samarbeidEtterSlett shouldHaveSize 1

        val sisteHendelse = postgresContainerHelper.hentEnkelKolonne<String>(
            """
            select id from ia_sak_hendelse where saksnummer = '${sak.saksnummer}' order by  opprettet desc limit 1
            """.trimIndent(),
        )
        sisteHendelse shouldBe sak.endretAvHendelseId
    }

    @Test
    fun `skal kunne opprette et nytt samarbeid med navn`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid(navn = "Navn")
        sak.hentAlleSamarbeid().forExactlyOne {
            it.navn shouldBe "Navn"
        }
    }

    @Test
    fun `skal kun kunne opprette samarbeid med unikt navn`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid(navn = "Navn")
        shouldFail { sak.opprettNyttSamarbeid(navn = "Navn") }.message shouldBe "HTTP Exception 409 Conflict Samarbeidsnavn finnes allerede"
        shouldFail { sak.opprettNyttSamarbeid(navn = "navn") }.message shouldBe "HTTP Exception 409 Conflict Samarbeidsnavn finnes allerede"

        sak.hentAlleSamarbeid().count { it.navn == "Navn" } shouldBeExactly 1
    }

    @Test
    fun `samarbeidsnavn er begrenset til 50 tegn`() {
        val sak = nySakIKartlegges()

        val forLangtNavn = "n".repeat(MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN + 1)
        val gyldigLangtNavn = "n".repeat(MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN)
        val nyttGydigLangtNavn = "o".repeat(MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN)
        shouldFail {
            sak.opprettNyttSamarbeid(navn = forLangtNavn)
        }
        val sakMedSamarbeid = sak.opprettNyttSamarbeid(navn = gyldigLangtNavn)
        val samarbeid = sakMedSamarbeid.hentAlleSamarbeid().first()
        shouldFail {
            sakMedSamarbeid.nyttNavnPåSamarbeid(samarbeid, forLangtNavn)
        }
        sakMedSamarbeid.nyttNavnPåSamarbeid(samarbeid, nyttGydigLangtNavn)
    }

    @Test
    fun `skal gå tilbake til forrige status dersom man trykker tilbake etter å ha slettet prosess`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val sakEtterSlettetSamarbeid = sak.slettSamarbeid(samarbeid)
        sakEtterSlettetSamarbeid.status shouldBe IAProsessStatus.KARTLEGGES

        val sakEtterTilbake = sakEtterSlettetSamarbeid.nyHendelse(IASakshendelseType.TILBAKE)
        sakEtterTilbake.status shouldBe IAProsessStatus.KONTAKTES
    }
}
