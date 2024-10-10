package no.nav.lydia.container.ia.eksport

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
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentIAProsesser
import no.nav.lydia.ia.sak.api.plan.PlanDto
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
    fun `Nyopprettet samarbeidsplan skal sendes til salesforce`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
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
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = opprettetPlan.id,
                konsument = samarbeidsplanKonsument
            ) {
                it.forExactlyOne { melding ->
                    val plan = Json.decodeFromString<PlanDto>(melding)
                    plan.id shouldBe opprettetPlan.id
                    plan.temaer.size shouldBeExactly opprettetPlan.temaer.size
                    plan.sistEndret shouldBeGreaterThan opprettetPlan.sistEndret
                }
            }
        }
    }
}