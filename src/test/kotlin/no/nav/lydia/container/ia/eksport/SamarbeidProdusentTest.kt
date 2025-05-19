package no.nav.lydia.container.ia.eksport

import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.SakHelper.Companion.fullførSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.eksport.SamarbeidProdusent.SamarbeidKafkaMeldingValue
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.domene.prosess.IAProsessStatus
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class SamarbeidProdusentTest {
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
    fun `fullføring av samarbeid skal gi fullføre-melding til SF`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())
        sak.fullførSamarbeid(samarbeid)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak.saksnummer}-${samarbeid.id}",
                konsument = konsument,
            ) { meldinger ->
                meldinger.forAtLeastOne { melding ->
                    val samarbeidSentTilSalesforce = Json.decodeFromString<SamarbeidKafkaMeldingValue>(melding)
                    samarbeidSentTilSalesforce.samarbeid.status shouldBe IAProsessStatus.FULLFØRT
                }
            }
        }
    }

    @Test
    fun `Nyopprettet samarbeid skal sendes til salesforce`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()

        runBlocking {
            konsummerOgSjekkKafkaMelding(
                sak1 = sak,
                samarbeid1 = samarbeid,
            )
        }
    }

    private suspend fun konsummerOgSjekkKafkaMelding(
        sak1: IASakDto,
        samarbeid1: IAProsessDto,
    ) {
        kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
            key = "${sak1.saksnummer}-${samarbeid1.id}",
            konsument = konsument,
        ) {
            it.forExactlyOne { melding ->
                val samarbeidSentTilSalesforce = Json.decodeFromString<SamarbeidKafkaMeldingValue>(melding)
                samarbeidIKafkaErRiktigPlan(
                    samarbeidKafkaMelding = samarbeidSentTilSalesforce,
                    sak = sak1,
                    samarbeid = samarbeid1,
                )
            }
        }
    }

    private fun samarbeidIKafkaErRiktigPlan(
        samarbeidKafkaMelding: SamarbeidKafkaMeldingValue,
        sak: IASakDto,
        samarbeid: IAProsessDto,
    ) {
        samarbeidKafkaMelding.orgnr shouldBe sak.orgnr
        samarbeidKafkaMelding.saksnummer shouldBe sak.saksnummer
        samarbeidKafkaMelding.samarbeid.id shouldBe samarbeid.id
        samarbeidKafkaMelding.samarbeid.navn shouldBe samarbeid.navn
        samarbeidKafkaMelding.samarbeid.status shouldBe samarbeid.status
        samarbeidKafkaMelding.samarbeid.endretTidspunkt shouldNotBe null
    }
}
