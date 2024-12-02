package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.AVSLUTTET
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.PÅBEGYNT
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldBeInteger
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.eksport.FullførtBehovsvurdering
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class FullførtBehovsvurderingProdusentTest {
    companion object {
        private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = Topic.FULLFØRT_BEHOVSVURDERING_TOPIC.konsumentGruppe)

        @BeforeClass
        @JvmStatic
        fun setUp() {
            konsument.subscribe(mutableListOf(Topic.FULLFØRT_BEHOVSVURDERING_TOPIC.navn))
        }

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
        val kartleggingDto = sak.opprettSpørreundersøkelse()
        val påbegyntKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntKartlegging.status shouldBe PÅBEGYNT

        val avsluttetKartlegging = påbegyntKartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        avsluttetKartlegging.status shouldBe AVSLUTTET

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
