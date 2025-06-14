package no.nav.lydia.container.ia.eksport

import io.kotest.inspectors.shouldForAll
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.PlanHelper.Companion.endreEttTemaIPlan
import no.nav.lydia.helper.PlanHelper.Companion.endreFlereTemaerIPlan
import no.nav.lydia.helper.PlanHelper.Companion.endreStatusPåInnholdIPlan
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.inkluderEttTemaOgEttInnhold
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.ia.eksport.SamarbeidsplanBigqueryProdusent.InnholdIPlanMelding
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class SamarbeidsplanBigqueryEksportererTest {
    companion object {
        private val topic = Topic.SAMARBEIDSPLAN_BIGQUERY_TOPIC
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
    fun `oppretting av plan skal trigge kafka-eksport til BigQuery`() {
        val sak = nySakIViBistår()
        val planMalDto: PlanMalDto = hentPlanMal()
        val plan = sak.opprettEnPlan(plan = planMalDto.inkluderAlt())

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = plan.id,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                val planer = meldinger.map { Json.decodeFromString<List<InnholdIPlanMelding>>(it) }
                val sistePlan = planer.last()
                sistePlan.shouldForAll { it.planId shouldBe plan.id }
                sistePlan.planlagteTemaer() shouldBe plan.temaer.size
                sistePlan.planlagtInnhold() shouldBe plan.temaer.sumOf { it.undertemaer.size }
            }
        }
    }

    @Test
    fun `endring av hele planen skal trigge kafka-eksport til BigQuery`() {
        val sak = nySakIViBistår()
        val enTomPlan: PlanMalDto = hentPlanMal()
        val plan = sak.opprettEnPlan(plan = enTomPlan)
        val planMedAlt = plan.inkluderAlt()

        sak.endreFlereTemaerIPlan(
            endring = planMedAlt.tilRequest(),
        )

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = plan.id,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 2
                val planer = meldinger.map { Json.decodeFromString<List<InnholdIPlanMelding>>(it) }
                val sistePlan = planer.last()
                sistePlan.shouldForAll { it.planId shouldBe plan.id }
                sistePlan.planlagteTemaer() shouldBe plan.temaer.size
                sistePlan.planlagtInnhold() shouldBe plan.temaer.sumOf { it.undertemaer.size }
            }
        }
    }

    @Test
    fun `endring av tema skal trigge kafka-eksport til BigQuery`() {
        val sak = nySakIViBistår()
        val enTomPlan: PlanMalDto = hentPlanMal()
        val plan = sak.opprettEnPlan(
            plan = enTomPlan.inkluderEttTemaOgEttInnhold(
                temanummer = 3,
                innholdnummer = 1,
            ),
        )

        sak.endreEttTemaIPlan(
            temaId = plan.temaer.last().id,
            endring = plan.inkluderAlt().tilRequest().last().undertemaer,
        )

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = plan.id,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 2
                val planer = meldinger.map { Json.decodeFromString<List<InnholdIPlanMelding>>(it) }
                val sistePlan = planer.last()
                sistePlan.shouldForAll { it.planId shouldBe plan.id }
                sistePlan.planlagteTemaer() shouldBe 1
                sistePlan.planlagtInnhold() shouldBe plan.temaer.last().undertemaer.size
            }
        }
    }

    @Test
    fun `endret status på innhold skal trigge kafka-eksport til BigQuery`() {
        val sak = nySakIViBistår()
        val enPlanMedAltMed: PlanMalDto = hentPlanMal().inkluderAlt()
        val plan = sak.opprettEnPlan(plan = enPlanMedAltMed)

        val sisteTema = plan.temaer.last()
        val sisteInnhold = sisteTema.undertemaer.last()

        val nyStatus = PlanUndertema.Status.PÅGÅR

        sak.endreStatusPåInnholdIPlan(
            temaId = sisteTema.id,
            innholdId = sisteInnhold.id,
            status = nyStatus,
        )

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = plan.id,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 2
                val planer = meldinger.map { Json.decodeFromString<List<InnholdIPlanMelding>>(it) }
                val sistePlan = planer.last()
                sistePlan.shouldForAll { it.planId shouldBe plan.id }
                sistePlan.planlagteTemaer() shouldBe 3
                sistePlan.planlagtInnhold() shouldBe plan.temaer.sumOf { it.undertemaer.size }
            }
        }
    }

    private fun List<InnholdIPlanMelding>.planlagteTemaer(): Int =
        this.groupBy { it.temaId }.filter { innholdITema -> innholdITema.value.any { it.inkludert } }.size

    private fun List<InnholdIPlanMelding>.planlagtInnhold(): Int = this.filter { it.inkludert }.size
}
