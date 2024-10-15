package no.nav.lydia.container.ia.eksport

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.hentIAProsesser
import no.nav.lydia.helper.opprettNyProsses
import no.nav.lydia.ia.eksport.SamarbeidBigqueryProdusent
import org.junit.After
import org.junit.Before
import kotlin.test.Test

class SamarbeidBigqueryEksportererTest {
    private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

    @Before
    fun setUp() {
        konsument.subscribe(mutableListOf(Topic.SAMARBEID_BIGQUERY_TOPIC.navn))
    }

    @After
    fun tearDown() {
        konsument.unsubscribe()
        konsument.close()
    }

    @Test
    fun `oppretting av samarbeid skal trigge kafka-eksport av samarbeid`() {
        val sak = SakHelper.nySakIKartlegges()
        val samarbeid = sak.opprettNyProsses().hentIAProsesser().first()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveSize 1
                val samarbeidValues = meldinger.map {
                    Json.decodeFromString<SamarbeidBigqueryProdusent.SamarbeidValue>(it)
                }
                samarbeidValues shouldHaveSize 1
                val sisteSamarbeid = samarbeidValues.last()
                sisteSamarbeid.id shouldBe samarbeid.id
                sisteSamarbeid.saksnummer shouldBe sak.saksnummer
            }
        }
    }
}
