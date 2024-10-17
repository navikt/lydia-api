package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.jobbsender.Jobb
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.shouldBe
import kotlin.test.Test
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.LocalDate
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentIAProsesser
import no.nav.lydia.ia.eksport.SamarbeidsplanKafkaMelding
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import org.junit.After
import org.junit.Before

class SamarbeidsplanProdusentTest {
    private val samarbeidsplanKonsument = kafkaContainerHelper.nyKonsument(
        Topic.SAMARBEIDSPLAN_TOPIC.konsumentGruppe
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
    fun `starter re-eksport av alle samarbeidsplaner til salesforce` () {
        val planMal: PlanMalDto = PlanHelper.hentPlanMal()
        // Opprette noen saker med planer
        val sak1 = nySakIKartleggesMedEtSamarbeid()
        val samarbeid1 = sak1.hentIAProsesser().first()
        val opprettetPlan1 = PlanHelper.opprettEnPlan(
            orgnr = sak1.orgnr,
            saksnummer = sak1.saksnummer,
            prosessId = samarbeid1.id,
            redigertPlan = planMal
        )
        // lytte og konsummere kafka meldingen sendt til SF av "opprett plan funksjon"
        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak1.saksnummer}-${samarbeid1.id}-${opprettetPlan1.id}",
                konsument = samarbeidsplanKonsument
            ) {
                println("Fikk en kafka melding for ${sak1.orgnr} ")
            }
        }

        val sak2 = nySakIKartleggesMedEtSamarbeid()
        val samarbeid2 = sak2.hentIAProsesser().first()
        val opprettetPlan2 = PlanHelper.opprettEnPlan(
            orgnr = sak2.orgnr,
            saksnummer = sak2.saksnummer,
            prosessId = samarbeid2.id,
            redigertPlan = planMal
        )
        // lytte og konsummere alle kafka meldingen sendt til SF av "opprett plan funksjon"
        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak2.saksnummer}-${samarbeid2.id}-${opprettetPlan2.id}",
                konsument = samarbeidsplanKonsument
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
        lydiaApiContainer shouldContainLog "Ferdig med re-eksport av 2/2 samarbeidsplan".toRegex()
    }

    @Test
    fun `Nyopprettet samarbeidsplan skal sendes til salesforce`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentIAProsesser().first()
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
            prosessId = sak.hentIAProsesser().first().id,
            redigertPlan = planMedEttTema
        )

        runBlocking {
            konsummerOgSjekkKafkaMelding(sak, samarbeid, opprettetPlan)
        }
    }


    private suspend fun konsummerOgSjekkKafkaMelding(
        sak1: IASakDto,
        samarbeid1: IAProsessDto,
        opprettetPlan1: PlanDto
    ) {
        kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
            key = "${sak1.saksnummer}-${samarbeid1.id}-${opprettetPlan1.id}",
            konsument = samarbeidsplanKonsument
        ) {
            it.forExactlyOne { melding ->
                val planTilSalesforce = Json.decodeFromString<SamarbeidsplanKafkaMelding>(melding)
                planIKafkaErRiktigPlan(
                    planTilSalesforce = planTilSalesforce,
                    sak = sak1,
                    samarbeid = samarbeid1,
                    opprettetPlan = opprettetPlan1
                )
            }
        }
    }

    private fun planIKafkaErRiktigPlan(
        planTilSalesforce: SamarbeidsplanKafkaMelding,
        sak: IASakDto,
        samarbeid: IAProsessDto,
        opprettetPlan: PlanDto
    ) {
        planTilSalesforce.orgnr shouldBe sak.orgnr
        planTilSalesforce.saksnummer shouldBe sak.saksnummer
        planTilSalesforce.samarbeid.id shouldBe samarbeid.id
        planTilSalesforce.samarbeid.navn shouldBe samarbeid.navn
        planTilSalesforce.samarbeid.status shouldBe samarbeid.status
        planTilSalesforce.plan.id shouldBe opprettetPlan.id
        planTilSalesforce.plan.temaer.size shouldBeExactly opprettetPlan.temaer.size
        planTilSalesforce.plan.sistEndret shouldBeGreaterThan opprettetPlan.sistEndret
    }
}