package no.nav.lydia.container.ia.eksport

import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldBeInteger
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettBehovsvurdering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.eksport.FullførtBehovsvurderingProdusent.FullførtBehovsvurdering
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class FullførtBehovsvurderingProdusentTest {
    companion object {
        private val topic = Topic.FULLFØRT_BEHOVSVURDERING_TOPIC
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
    fun `fullført behovsvurdering skal sendes til salesforce`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val kartleggingDto = sak.opprettBehovsvurdering()
        val påbegyntKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntKartlegging.status shouldBe SpørreundersøkelseDomene.Status.PÅBEGYNT

        val avsluttetKartlegging = påbegyntKartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        avsluttetKartlegging.status shouldBe SpørreundersøkelseDomene.Status.AVSLUTTET

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.id,
                konsument = konsument,
            ) {
                it.forExactlyOne { melding ->
                    val behovsvurdering = Json.decodeFromString<FullførtBehovsvurdering>(melding)
                    behovsvurdering.behovsvurderingId shouldBe avsluttetKartlegging.id
                    behovsvurdering.prosessId.shouldBeInteger()
                }
            }
        }
    }
}
