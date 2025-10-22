package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.jobbsender.Jobb.iaSakSamarbeidEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakSamarbeidEksportEttSamarbeid
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.eksport.SAMARBEID_ID_PREFIKS
import no.nav.lydia.ia.eksport.SamarbeidProdusent.SamarbeidKafkaMeldingValue
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class SamarbeidEksportererTest {
    companion object {
        private val topic = Topic.SAMARBEIDSPLAN_TOPIC
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
    fun `skal trigge kafka-eksport av enkelt samarbeid`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()

        // Opprettelse av ett samarbeid på en sak trigger utsendelse til Kafka -> vi må lese denne meldingen først
        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak.saksnummer}-${samarbeid.id}",
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                meldinger.forAtLeastOne {
                    it shouldContain sak.saksnummer
                }
            }
        }

        // Start jobben som skal sende en melding om IA-sak på Kafka
        val samarbeidIdParameter = "${SAMARBEID_ID_PREFIKS}${samarbeid.id}"
        kafkaContainerHelper.sendJobbMelding(iaSakSamarbeidEksportEttSamarbeid, parameter = samarbeidIdParameter)
        runBlocking {
            // Sjekk at denne meldingen ble sendt på Kafka
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak.saksnummer}-${samarbeid.id}",
                konsument = konsument,
            ) {
                it.forExactlyOne { melding ->
                    val samarbeidKafkaMelding = Json.decodeFromString<SamarbeidKafkaMeldingValue>(melding)
                    samarbeidKafkaMelding.orgnr shouldBe sak.orgnr
                    samarbeidKafkaMelding.saksnummer shouldBe sak.saksnummer
                    samarbeidKafkaMelding.samarbeid.id shouldBe samarbeid.id
                    samarbeidKafkaMelding.samarbeid.navn shouldBe samarbeid.navn
                    samarbeidKafkaMelding.samarbeid.status shouldBe samarbeid.status
                    samarbeidKafkaMelding.samarbeid.endretTidspunkt shouldNotBe null
                }
            }
        }
        applikasjon shouldContainLog "Ferdig med eksport av samarbeid med parameter: '$samarbeidIdParameter'".toRegex()
    }

    @Test
    fun `skal trigge kafka-eksport av alle samarbeid`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()

        // Opprettelse av ett samarbeid på en sak trigger utsendelse til Kafka -> vi må lese denne meldingen først
        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak.saksnummer}-${samarbeid.id}",
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                meldinger.forAtLeastOne {
                    it shouldContain sak.saksnummer
                }
            }
        }

        // Start jobben som skal sende en melding om IA-sak på Kafka
        kafkaContainerHelper.sendJobbMelding(iaSakSamarbeidEksport)
        runBlocking {
            // Sjekk at denne meldingen ble sendt på Kafka
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak.saksnummer}-${samarbeid.id}",
                konsument = konsument,
            ) {
                it.forExactlyOne { melding ->
                    val samarbeidKafkaMelding = Json.decodeFromString<SamarbeidKafkaMeldingValue>(melding)
                    samarbeidKafkaMelding.orgnr shouldBe sak.orgnr
                    samarbeidKafkaMelding.saksnummer shouldBe sak.saksnummer
                    samarbeidKafkaMelding.samarbeid.id shouldBe samarbeid.id
                    samarbeidKafkaMelding.samarbeid.navn shouldBe samarbeid.navn
                    samarbeidKafkaMelding.samarbeid.status shouldBe samarbeid.status
                    samarbeidKafkaMelding.samarbeid.endretTidspunkt shouldNotBe null
                }
            }
        }
        applikasjon shouldContainLog "Ferdig med eksport av alle samarbeid".toRegex()
    }
}
