package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.jobbsender.Jobb
import io.kotest.assertions.shouldFail
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.LocalDate
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.eksport.SamarbeidsplanKafkaMelding
import no.nav.lydia.ia.sak.DEFAULT_SAMARBEID_NAVN
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import org.junit.After
import org.junit.Before
import kotlin.test.Test

class SamarbeidsplanProdusentTest {
    private val samarbeidsplanKonsument = kafkaContainerHelper.nyKonsument(
        Topic.SAMARBEIDSPLAN_TOPIC.konsumentGruppe,
    )

    @Before
    fun setUp() {
        samarbeidsplanKonsument.subscribe(listOf(Topic.SAMARBEIDSPLAN_TOPIC.navn))
    }

    @After
    fun tearDown() {
        samarbeidsplanKonsument.unsubscribe()
        samarbeidsplanKonsument.close()
    }

    @Test
    fun `starter re-eksport av alle samarbeidsplaner til salesforce`() {
        val planMal: PlanMalDto = PlanHelper.hentPlanMal()
        // Opprette noen saker med planer
        val sak1 = nySakIKartleggesMedEtSamarbeid()
        val samarbeid1 = sak1.hentAlleSamarbeid().first()
        val opprettetPlan1 = PlanHelper.opprettEnPlan(
            orgnr = sak1.orgnr,
            saksnummer = sak1.saksnummer,
            prosessId = samarbeid1.id,
            plan = planMal,
        )
        // lytte og konsummere kafka meldingen sendt til SF av "opprett plan funksjon"
        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak1.saksnummer}-${samarbeid1.id}-${opprettetPlan1.id}",
                konsument = samarbeidsplanKonsument,
            ) {
                println("Fikk en kafka melding for ${sak1.orgnr} ")
            }
        }

        val sak2 = nySakIKartleggesMedEtSamarbeid()
        val samarbeid2 = sak2.hentAlleSamarbeid().first()
        val opprettetPlan2 = PlanHelper.opprettEnPlan(
            orgnr = sak2.orgnr,
            saksnummer = sak2.saksnummer,
            prosessId = samarbeid2.id,
            plan = planMal,
        )
        // lytte og konsummere alle kafka meldingen sendt til SF av "opprett plan funksjon"
        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak2.saksnummer}-${samarbeid2.id}-${opprettetPlan2.id}",
                konsument = samarbeidsplanKonsument,
            ) {
                println("Fikk en kafka melding for ${sak2.orgnr} ")
            }
        }

        // sende en jobbmelding på Kafka
        kafkaContainerHelper.sendJobbMelding(Jobb.iaSakSamarbeidsplanEksport)

        // sjekk at vi sender på Kafka (obs: klarer ikke å hente alle meldingene)
        runBlocking {
            konsummerOgSjekkKafkaMelding(sak1, samarbeid1, opprettetPlan1)
        }
        lydiaApiContainer shouldContainLog "Jobb '${Jobb.iaSakSamarbeidsplanEksport.name}' ferdig".toRegex()
    }

    @Test
    fun `re-eksport av samarbeidsplaner til salesforce hvor samarbeid har et tomt (null) navn`() {
        val planMal: PlanMalDto = PlanHelper.hentPlanMal()
        val sak1 = nySakIKartlegges().opprettNyttSamarbeid(navn = null)

        val samarbeid1 = sak1.hentAlleSamarbeid().first()
        val opprettetPlan1 = PlanHelper.opprettEnPlan(
            orgnr = sak1.orgnr,
            saksnummer = sak1.saksnummer,
            prosessId = samarbeid1.id,
            plan = planMal,
        )
        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak1.saksnummer}-${samarbeid1.id}-${opprettetPlan1.id}",
                konsument = samarbeidsplanKonsument,
            ) {
                println("Fikk en kafka melding for ${sak1.orgnr} ")
            }
        }

        kafkaContainerHelper.sendJobbMelding(Jobb.iaSakSamarbeidsplanEksport)

        runBlocking {
            konsummerOgSjekkKafkaMelding(sak1, samarbeid1, opprettetPlan1)
        }
    }

    @Test
    fun `Nyopprettet samarbeidsplan skal sendes til salesforce`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val planMal: PlanMalDto = PlanHelper.hentPlanMal()

        val startDato = LocalDate(2010, 1, 1)
        val sluttDato = LocalDate(2025, 2, 2)

        val planMedEttTema = planMal.copy(
            tema = planMal.tema.map { tema ->
                if (tema.rekkefølge == 2) {
                    tema.copy(
                        inkludert = true,
                        innhold = tema.innhold.map { innhold ->
                            innhold.copy(
                                inkludert = true,
                                startDato = startDato,
                                sluttDato = sluttDato,
                            )
                        },
                    )
                } else {
                    tema
                }
            },
        )

        val opprettetPlan = PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            plan = planMedEttTema,
        )

        runBlocking {
            konsummerOgSjekkKafkaMelding(
                sak1 = sak,
                samarbeid1 = samarbeid,
                opprettetPlan1 = opprettetPlan,
                startDato = startDato,
                sluttDato = sluttDato,
            )
        }
    }

    @Test
    fun `Skal ikke kunne opprette duplisert plan`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val planMal: PlanMalDto = PlanHelper.hentPlanMal()

        PlanHelper.opprettEnPlan(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            plan = planMal,
        )
        shouldFail {
            PlanHelper.opprettEnPlan(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = sak.hentAlleSamarbeid().first().id,
                plan = planMal,
            )
        }
        postgresContainer.hentEnkelKolonne<Int>(
            """
            SELECT COUNT(*) FROM ia_sak_plan WHERE ia_prosess = '${samarbeid.id}'
            """.trimIndent(),
        ).toInt() shouldBe 1
    }

    private suspend fun konsummerOgSjekkKafkaMelding(
        sak1: IASakDto,
        samarbeid1: IAProsessDto,
        opprettetPlan1: PlanDto,
        startDato: LocalDate? = null,
        sluttDato: LocalDate? = null,
    ) {
        kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
            key = "${sak1.saksnummer}-${samarbeid1.id}-${opprettetPlan1.id}",
            konsument = samarbeidsplanKonsument,
        ) {
            it.forExactlyOne { melding ->
                val planTilSalesforce = Json.decodeFromString<SamarbeidsplanKafkaMelding>(melding)
                planIKafkaErRiktigPlan(
                    planTilSalesforce = planTilSalesforce,
                    sak = sak1,
                    samarbeid = samarbeid1,
                    opprettetPlan = opprettetPlan1,
                    startDato = startDato,
                    sluttDato = sluttDato,
                )
            }
        }
    }

    private fun planIKafkaErRiktigPlan(
        planTilSalesforce: SamarbeidsplanKafkaMelding,
        sak: IASakDto,
        samarbeid: IAProsessDto,
        opprettetPlan: PlanDto,
        startDato: LocalDate?,
        sluttDato: LocalDate?,
    ) {
        planTilSalesforce.orgnr shouldBe sak.orgnr
        planTilSalesforce.saksnummer shouldBe sak.saksnummer
        planTilSalesforce.samarbeid.id shouldBe samarbeid.id
        if (startDato != null) {
            planTilSalesforce.samarbeid.startDato shouldBe startDato
        }
        if (sluttDato != null) {
            planTilSalesforce.samarbeid.sluttDato shouldBe sluttDato
        }
        if (samarbeid.navn == null) {
            planTilSalesforce.samarbeid.navn shouldBe DEFAULT_SAMARBEID_NAVN
        } else {
            planTilSalesforce.samarbeid.navn shouldBe samarbeid.navn
        }
        planTilSalesforce.samarbeid.status shouldBe samarbeid.status
        planTilSalesforce.plan.id shouldBe opprettetPlan.id
        planTilSalesforce.plan.temaer.size shouldBeExactly opprettetPlan.temaer.size
        planTilSalesforce.plan.sistEndret shouldBeGreaterThan opprettetPlan.sistEndret
    }
}
