package no.nav.lydia.container.ia.eksport

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.ia.eksport.SamarbeidsplanBigqueryProdusent
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import org.junit.After
import org.junit.Before
import kotlin.test.Test

class SamarbeidsplanBigqueryEksportererTest {
    private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

    @Before
    fun setUp() {
        konsument.subscribe(listOf(Topic.SAMARBEIDSPLAN_BIGQUERY_TOPIC.navn))
    }

    @After
    fun tearDown() {
        konsument.unsubscribe()
        konsument.close()
    }

    @Test
    fun `oppretting av plan skal trigge kafka-eksport til BigQuery`() {
        val sak = nySakIViBistår()

        val planMalDto: PlanMalDto = hentPlanMal()

        val plan = sak.opprettEnPlan(
            plan = planMalDto.inkluderAlt(),
        )

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = plan.id,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveSize 1
                val planer = meldinger.map {
                    Json.decodeFromString<SamarbeidsplanBigqueryProdusent.PlanValue>(it)
                }
                planer shouldHaveSize 1
                val sistePlan = planer.last()
                sistePlan.id shouldBe plan.id
                sistePlan.planlagteTemaer() shouldBe plan.temaer.size
                sistePlan.planlagtInnhold() shouldBe plan.temaer.sumOf { it.undertemaer.size }
            }
        }
    }

    private fun SamarbeidsplanBigqueryProdusent.PlanValue.planlagteTemaer(): Int = this.temaer.filter { it.inkludert }.size

    private fun SamarbeidsplanBigqueryProdusent.PlanValue.planlagtInnhold(): Int =
        this.temaer.flatMap {
            it.innhold
        }.filter { it.inkludert }.size
}
