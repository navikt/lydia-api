package no.nav.lydia.container.ia.sak.prosess

import io.kotest.assertions.shouldFail
import io.kotest.assertions.shouldFailWithMessage
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldContainExactlyInAnyOrder
import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.comparables.shouldBeLessThan
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.aktivSamarbeidsperiode
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.avsluttSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.endreSamarbeidsNavn
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.slettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.fullfør
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettBehovsvurdering
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettEvaluering
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.slett
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.start
import no.nav.lydia.helper.PlanHelper.Companion.endreFlereTemaerIPlan
import no.nav.lydia.helper.PlanHelper.Companion.endreStatusPåInnholdIPlan
import no.nav.lydia.helper.PlanHelper.Companion.hentPlan
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.PlanHelper.Companion.opprettSamarbeidsplan
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.bliEier
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikk
import no.nav.lydia.helper.SakHelper.Companion.kanGjennomføreStatusendring
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.eksport.SamarbeidsplanKafkaMelding
import no.nav.lydia.ia.sak.DEFAULT_SAMARBEID_NAVN
import no.nav.lydia.ia.sak.IASamarbeidService.StatusendringBegrunnelser
import no.nav.lydia.ia.sak.MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
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
        private val konsument = kafkaContainerHelper.nyKonsument(topic = topic)

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
    fun `følger av sak skal kunne opprette og endre samarbeid`() {
        val eierAvSak = authContainerHelper.saksbehandler1
        val sak = vurderVirksomhet()
        sak.bliEier(eierAvSak.token)

        val følgerAvSak = authContainerHelper.saksbehandler2
        sak.leggTilFolger(token = følgerAvSak.token)

        val samarbeid = sak.opprettSamarbeid(
            samarbeidsnavn = "Første",
            token = følgerAvSak.token,
        )
        samarbeid.endreSamarbeidsNavn(
            orgnr = sak.orgnr,
            nyttNavn = "Nytt navn",
            token = følgerAvSak.token,
        )
        samarbeid.avsluttSamarbeid(
            orgnr = sak.orgnr,
            avslutningsType = IASamarbeid.Status.AVBRUTT,
            token = følgerAvSak.token,
        )
        sak.hentAlleSamarbeid().forExactlyOne {
            it.status shouldBe IASamarbeid.Status.AVBRUTT
            it.navn shouldBe "Nytt navn"
        }
    }

    @Test
    fun `skal få avbrutte samarbeid i listen over alle samarbeid`() {
        val sak = vurderVirksomhet().leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid(samarbeidsnavn = "Avbrutt samarbeid")
        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.AVBRUTT)
        sak.hentAlleSamarbeid().forExactlyOne { samarbeid ->
            samarbeid.navn shouldBe "Avbrutt samarbeid"
            samarbeid.status shouldBe IASamarbeid.Status.AVBRUTT
        }
    }

    @Test
    fun `skal ikke kunne avbryte samarbeid som inneholder spørreundersøkelser`() {
        val sak = vurderVirksomhet().leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        sak.opprettBehovsvurdering()

        shouldFailWithMessage("HTTP Exception 400 Bad Request") {
            samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.AVBRUTT)
        }
    }

    @Test
    fun `skal kunne fullføre et samarbeid`() {
        val sak = aktivSamarbeidsperiode()
        val samarbeid = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())

        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)
        postgresContainerHelper.hentEnkelKolonne<String>(
            "SELECT status FROM ia_prosess WHERE id = ${samarbeid.id}",
        ) shouldBe IASamarbeid.Status.FULLFØRT.name
    }

    @Test
    fun `fullføring av samarbeid skal oppdatere fullført_tidspunkt`() {
        val sak = aktivSamarbeidsperiode()
        val samarbeid = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())

        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)
        postgresContainerHelper.hentEnkelKolonne<String>(
            "SELECT fullfort_tidspunkt FROM ia_prosess WHERE id = ${samarbeid.id}",
        ).shouldNotBeNull()
    }

    @Test
    fun `avbryting av samarbeid skal oppdatere avbrutt_tidspunkt`() {
        val sak = aktivSamarbeidsperiode()
        val samarbeid = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())

        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.AVBRUTT)
        postgresContainerHelper.hentEnkelKolonne<String>(
            "SELECT avbrutt_tidspunkt FROM ia_prosess WHERE id = ${samarbeid.id}",
        ).shouldNotBeNull()
    }

    @Test
    fun `fullførte samarbeid skal inkluderes i listen over samarbeid for en sak`() {
        val sak = aktivSamarbeidsperiode()
        val samarbeid = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())

        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)
        sak.hentAlleSamarbeid() shouldHaveSize 1
    }

    @Test
    fun `skal fullføre alle inkluderte undertemaer i plan når samarbeid fullføres`() {
        val sak = aktivSamarbeidsperiode()
        val samarbeidSomFullføres = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())
        samarbeidSomFullføres.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)
        val plan = sak.hentPlan(prosessId = samarbeidSomFullføres.id)
        plan.temaer.forAll { tema ->
            tema.undertemaer.forAll { undertema ->
                undertema.status shouldBe PlanUndertema.Status.FULLFØRT
            }
        }
    }

    @Test
    fun `skal ikke fullføre avbrutte undertemaer når samarbeid fullføres`() {
        val sak = aktivSamarbeidsperiode()
        val samarbeidSomFullføres = sak.hentAlleSamarbeid().first()
        val plan = sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())
        val tema = plan.temaer.first()
        val undertema = tema.undertemaer.first()
        sak.endreStatusPåInnholdIPlan(
            planId = plan.id,
            temaId = tema.id,
            innholdId = undertema.id,
            status = PlanUndertema.Status.AVBRUTT,
        )
        samarbeidSomFullføres.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)
        val planEtterFullføring = sak.hentPlan(prosessId = samarbeidSomFullføres.id)
        planEtterFullføring.temaer.flatMap { it.undertemaer }.forExactlyOne {
            it.status shouldBe PlanUndertema.Status.AVBRUTT
        }
    }

    @Test
    fun `skal få riktig historikk for saken etter fullført samarbeid`() {
        val sak = aktivSamarbeidsperiode()
        val samarbeidSomFullføres = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())

        samarbeidSomFullføres.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)
        val historikk = hentSamarbeidshistorikk(sak.orgnr)
        historikk.forExactlyOne { sakshistorikk ->
            sakshistorikk.sakshendelser.map { it.hendelsestype } shouldContainInOrder listOf(
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.OPPRETT_SAMARBEIDSPLAN,
                IASakshendelseType.FULLFØR_PROSESS,
            )
            sakshistorikk.samarbeid.forExactlyOne { samarbeid ->
                samarbeid.saksnummer shouldBe sak.saksnummer
                samarbeid.status shouldBe IASamarbeid.Status.FULLFØRT
            }
        }
    }

    @Test
    fun `skal få riktige begrunnelser for om et samarbeid kan avbrytes`() {
        val sak = aktivSamarbeidsperiode()
        sak.opprettBehovsvurdering()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val kanIkkeGjennomføres = sak.kanGjennomføreStatusendring(samarbeid, "avbrytes")
        kanIkkeGjennomføres.kanGjennomføres shouldBe false
        kanIkkeGjennomføres.blokkerende shouldBe listOf(StatusendringBegrunnelser.AKTIV_BEHOVSVURDERING)
    }

    @Test
    fun `skal få riktige begrunnelser for om et samarbeid kan fullføres`() {
        val sak = aktivSamarbeidsperiode()
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
            .fullfør(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val kanFullføresUtenAdvarsler = sak.kanGjennomføreStatusendring(samarbeid, "fullfores")
        kanFullføresUtenAdvarsler.kanGjennomføres shouldBe true
        kanFullføresUtenAdvarsler.advarsler shouldHaveSize 0
        kanFullføresUtenAdvarsler.blokkerende shouldHaveSize 0
    }

    @Test
    fun `skal få riktige begrunnelser for om et samarbeid kan slettes (NY)`() {
        val sak = aktivSamarbeidsperiode()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val skalKunneSlettes = sak.kanGjennomføreStatusendring(samarbeid, "slettes")
        skalKunneSlettes.kanGjennomføres shouldBe true
        skalKunneSlettes.blokkerende shouldHaveSize 0

        val behovsvurdering = sak.opprettBehovsvurdering()
        val skalIkkeKunneSlettesPgaBehovsVurdering = sak.kanGjennomføreStatusendring(samarbeid, "slettes")
        skalIkkeKunneSlettesPgaBehovsVurdering.kanGjennomføres shouldBe false
        skalIkkeKunneSlettesPgaBehovsVurdering.blokkerende shouldBe listOf(StatusendringBegrunnelser.FINNES_BEHOVSVURDERING)

        behovsvurdering.slett(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
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
    fun `endring på samarbeid oppdaterer sistEndret`() {
        val sak = aktivSamarbeidsperiode()
        val samarbeid = sak.hentAlleSamarbeid().first()

        samarbeid
            .endreSamarbeidsNavn(orgnr = sak.orgnr, nyttNavn = "Første")
            .endreSamarbeidsNavn(orgnr = sak.orgnr, nyttNavn = "Andre")
            .endreSamarbeidsNavn(orgnr = sak.orgnr, nyttNavn = "Tredje")

        val samarbeidMedNyttNavn = sak.hentAlleSamarbeid().first()

        samarbeidMedNyttNavn.navn shouldBe "Tredje"
        samarbeid.opprettet shouldBe samarbeidMedNyttNavn.opprettet
        samarbeid.sistEndret!! shouldBeLessThan samarbeidMedNyttNavn.sistEndret!!
    }

    @Test
    fun `tomme samarbeidsnavn skal ikke kunne lagres`() {
        val sak = vurderVirksomhet().leggTilFolger(authContainerHelper.saksbehandler1.token)
        shouldFail {
            sak.opprettSamarbeid(samarbeidsnavn = "")
        }
        val samarbeid = sak.opprettSamarbeid(samarbeidsnavn = DEFAULT_SAMARBEID_NAVN)
        shouldFail {
            samarbeid.endreSamarbeidsNavn(orgnr = sak.orgnr, nyttNavn = " ")
        }
        postgresContainerHelper.hentEnkelKolonne<String?>(
            """
            select navn from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        ) shouldBe DEFAULT_SAMARBEID_NAVN
    }

    @Test
    fun `oppdater endret_tidspunkt i DB ved endring av samarbeidsnavn`() {
        val sak = aktivSamarbeidsperiode(samarbeidsnavn = "Avdeling 1")
        val samarbeid = sak.hentAlleSamarbeid().first()

        val endretTidspunktVedOpprettelse = postgresContainerHelper.hentEnkelKolonne<Timestamp?>(
            """
            select endret_tidspunkt from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        )?.toLocalDateTime()
        endretTidspunktVedOpprettelse shouldNotBe null

        samarbeid.endreSamarbeidsNavn(orgnr = sak.orgnr, nyttNavn = "Avdeling 1 - Fysio")
        val endretTidspunktEtterUpdate = postgresContainerHelper.hentEnkelKolonne<Timestamp?>(
            """
            select endret_tidspunkt from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        )?.toLocalDateTime()

        endretTidspunktEtterUpdate!!.shouldBeGreaterThan(endretTidspunktVedOpprettelse!!)
    }

    @Test
    fun `oppdater endret_tidspunkt i DB ved sletting av samarbeid`() {
        val sak = aktivSamarbeidsperiode(samarbeidsnavn = "Avdeling 1")
        val samarbeid = sak.hentAlleSamarbeid().first()

        val endretTidspunktVedOpprettelse = postgresContainerHelper.hentEnkelKolonne<Timestamp?>(
            """
            select endret_tidspunkt from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        )?.toLocalDateTime()
        endretTidspunktVedOpprettelse shouldNotBe null

        samarbeid.slettSamarbeid(orgnr = sak.orgnr)
        val endretTidspunktEtterSlett = postgresContainerHelper.hentEnkelKolonne<Timestamp?>(
            """
            select endret_tidspunkt from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        )?.toLocalDateTime()

        endretTidspunktEtterSlett!!.shouldBeGreaterThan(endretTidspunktVedOpprettelse!!)
    }

    @Test
    fun `skal kunne opprette flere prosesser på samme sak`() {
        val sak = aktivSamarbeidsperiode()
        sak.hentAlleSamarbeid() shouldHaveSize 1
        sak.opprettSamarbeid(samarbeidsnavn = "Annet samarbeidsnavn")
        sak.hentAlleSamarbeid() shouldHaveSize 2
    }

    @Test
    fun `skal kunne opprette kartlegginger på saker der det er flere prosesser`() {
        val sak = aktivSamarbeidsperiode()
        sak.hentAlleSamarbeid() shouldHaveSize 1

        sak.opprettSamarbeid(samarbeidsnavn = "Annet samarbeidsnavn")
        sak.hentAlleSamarbeid() shouldHaveSize 2

        val behovsvurdering = sak.opprettBehovsvurdering()
        behovsvurdering.status shouldBe Spørreundersøkelse.Status.OPPRETTET
    }

    @Test
    fun `skal sende plan ved opprettelse av en ny plan på kafka`() {
        val sak = aktivSamarbeidsperiode()
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
        val sak = aktivSamarbeidsperiode()
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
        sak.endreFlereTemaerIPlan(
            planId = opprettetPlan.id,
            endring = opprettetPlan.inkluderAlt().tilRequest(),
        )

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
        val sak = aktivSamarbeidsperiode()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1
        alleSamarbeid.first().saksnummer shouldBe sak.saksnummer
    }

    @Test
    fun `skal kunne slette tomme samarbeid`() {
        val sak = vurderVirksomhet().leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        samarbeid.slettSamarbeid(orgnr = sak.orgnr)

        val samarbeidEtterSletting = sak.hentAlleSamarbeid()
        samarbeidEtterSletting shouldBe emptyList()
    }

    @Test
    fun `skal ikke kunne slette samarbeid som har en behovsvurdering knyttet til seg`() {
        val sak = vurderVirksomhet().leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        sak.opprettBehovsvurdering()
        shouldFail {
            samarbeid.slettSamarbeid(orgnr = sak.orgnr)
        }
        sak.hentAlleSamarbeid() shouldBe listOf(samarbeid)
    }

    @Test
    fun `skal ikke kunne slette prosesser som har en plan knyttet til seg`() {
        val sak = vurderVirksomhet().leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        shouldFail {
            samarbeid.slettSamarbeid(orgnr = sak.orgnr)
        }
        sak.hentAlleSamarbeid() shouldBe listOf(samarbeid)
    }

    @Test
    fun `skal ikke lagre SLETT_PROSESS hendelse dersom sletting ikke er lov`() {
        val sak = vurderVirksomhet().leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        sak.opprettBehovsvurdering()
        val sistEndretAvHendelse = hentSak(orgnummer = sak.orgnr).endretAvHendelseId
        shouldFail {
            samarbeid.copy(id = 1010000).slettSamarbeid(orgnr = sak.orgnr)
        }

        val samarbeidEtterSlett = sak.hentAlleSamarbeid()
        samarbeidEtterSlett shouldHaveSize 1

        val sisteHendelse = postgresContainerHelper.hentEnkelKolonne<String>(
            """
            select id from ia_sak_hendelse where saksnummer = '${sak.saksnummer}' order by  opprettet desc limit 1
            """.trimIndent(),
        )
        sisteHendelse shouldBe sistEndretAvHendelse
    }

    @Test
    fun `skal kun kunne opprette samarbeid med unikt navn`() {
        val sak = vurderVirksomhet().leggTilFolger(authContainerHelper.saksbehandler1.token)
        sak.opprettSamarbeid(samarbeidsnavn = "Navn")
        shouldFail { sak.opprettSamarbeid(samarbeidsnavn = "Navn") }.message shouldBe "HTTP Exception 409 Conflict"
        shouldFail { sak.opprettSamarbeid(samarbeidsnavn = "Navn") }.message shouldBe "HTTP Exception 409 Conflict"

        sak.hentAlleSamarbeid().count { it.navn == "Navn" } shouldBeExactly 1
    }

    @Test
    fun `samarbeidsnavn er begrenset til 50 tegn`() {
        val sak = vurderVirksomhet().leggTilFolger(authContainerHelper.saksbehandler1.token)

        val forLangtNavn = "n".repeat(MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN + 1)
        val gyldigLangtNavn = "n".repeat(MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN)
        val nyttGydigLangtNavn = "o".repeat(MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN)
        shouldFail {
            sak.opprettSamarbeid(samarbeidsnavn = forLangtNavn)
        }
        val samarbeid = sak.opprettSamarbeid(samarbeidsnavn = gyldigLangtNavn)
        shouldFail {
            samarbeid.endreSamarbeidsNavn(orgnr = sak.orgnr, nyttNavn = forLangtNavn)
        }
        samarbeid.endreSamarbeidsNavn(orgnr = sak.orgnr, nyttNavn = nyttGydigLangtNavn)
    }
}
