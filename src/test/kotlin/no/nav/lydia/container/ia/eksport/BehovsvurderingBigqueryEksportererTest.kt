package no.nav.lydia.container.ia.eksport

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.ia.eksport.BehovsvurderingBigqueryProdusent
import org.junit.After
import org.junit.Before
import kotlin.test.Test

class BehovsvurderingBigqueryEksportererTest {
    private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

    @Before
    fun setUp() {
        konsument.subscribe(mutableListOf(Topic.BEHOVSVURDERING_BIGQUERY_TOPIC.navn))
    }

    @After
    fun tearDown() {
        konsument.unsubscribe()
        konsument.close()
    }

    @Test
    fun `oppretting av behovsvurdering skal trigge kafka-eksport av behovsvurdering`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val opprettetBehovsvurdering = sak.opprettKartlegging()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveSize 1
                val behovsvurderingerUtenSvar = meldinger.map {
                    Json.decodeFromString<BehovsvurderingBigqueryProdusent.BehovsvurderingUtenSvarValue>(it)
                }
                behovsvurderingerUtenSvar shouldHaveSize 1
                val sisteBehovsvurdering = behovsvurderingerUtenSvar.last()
                sisteBehovsvurdering.id shouldBe opprettetBehovsvurdering.kartleggingId
                sisteBehovsvurdering.status shouldBe opprettetBehovsvurdering.status.name
                sisteBehovsvurdering.opprettetAv shouldBe opprettetBehovsvurdering.opprettetAv
                sisteBehovsvurdering.opprettet shouldBe opprettetBehovsvurdering.opprettetTidspunkt
                sisteBehovsvurdering.endret shouldBe opprettetBehovsvurdering.opprettetTidspunkt
                // For å unngå null i bigquery settes denne til opprettetTidspunkt ved startet kartlegging
                sisteBehovsvurdering.samarbeidId shouldBe opprettetBehovsvurdering.prosessId
            }
        }
    }

    @Test
    fun `starting av behovsvurdering skal trigge kafka-eksport av behovsvurdering`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val startetBehovsvurdering = sak.opprettKartlegging()
            .start(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
            )

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveSize 2

                val behovsvurderingerUtenSvar = meldinger.map {
                    Json.decodeFromString<BehovsvurderingBigqueryProdusent.BehovsvurderingUtenSvarValue>(it)
                }
                behovsvurderingerUtenSvar shouldHaveSize 2
                val sisteBehovsvurdering = behovsvurderingerUtenSvar.last()
                sisteBehovsvurdering.id shouldBe startetBehovsvurdering.kartleggingId
                sisteBehovsvurdering.status shouldBe startetBehovsvurdering.status.name
                sisteBehovsvurdering.opprettetAv shouldBe startetBehovsvurdering.opprettetAv
                sisteBehovsvurdering.opprettet shouldBe startetBehovsvurdering.opprettetTidspunkt
                sisteBehovsvurdering.endret shouldBe startetBehovsvurdering.endretTidspunkt
                sisteBehovsvurdering.samarbeidId shouldBe startetBehovsvurdering.prosessId
            }
        }
    }

    @Test
    fun `avslutting av behovsvurdering skal trigge kafka-eksport av behovsvurdering`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val avsluttetBehovsvurdering = sak.opprettKartlegging()
            .start(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
            )
            .avslutt(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
            )

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveSize 3
                val behovsvurderingerUtenSvar = meldinger.map {
                    Json.decodeFromString<BehovsvurderingBigqueryProdusent.BehovsvurderingUtenSvarValue>(it)
                }
                behovsvurderingerUtenSvar shouldHaveSize 3
                val sisteBehovsvurdering = behovsvurderingerUtenSvar.last()
                sisteBehovsvurdering.id shouldBe avsluttetBehovsvurdering.kartleggingId
                sisteBehovsvurdering.status shouldBe avsluttetBehovsvurdering.status.name
                sisteBehovsvurdering.opprettetAv shouldBe avsluttetBehovsvurdering.opprettetAv
                sisteBehovsvurdering.opprettet shouldBe avsluttetBehovsvurdering.opprettetTidspunkt
                sisteBehovsvurdering.endret shouldBe avsluttetBehovsvurdering.endretTidspunkt
                sisteBehovsvurdering.samarbeidId shouldBe avsluttetBehovsvurdering.prosessId
            }
        }
    }
}
