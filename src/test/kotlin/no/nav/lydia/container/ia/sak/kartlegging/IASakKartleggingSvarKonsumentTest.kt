package no.nav.lydia.container.ia.sak.kartlegging

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.sak.domene.KartleggingStatus
import no.nav.lydia.ia.sak.domene.SpørreundersøkelseDto
import org.junit.After
import org.junit.Before
import java.util.*
import kotlin.test.Test

class IASakKartleggingSvarKonsumentTest {

    val kartleggingKonsument = TestContainerHelper.kafkaContainerHelper.nyKonsument(this::class.java.name)

    @Before
    fun setUp() {
        kartleggingKonsument.subscribe(mutableListOf(Topic.SPORREUNDERSOKELSE_TOPIC.navn))
    }

    @After
    fun tearDown() {
        kartleggingKonsument.unsubscribe()
        kartleggingKonsument.close()
    }

    @Test
    fun `skal lagre svar mottatt på Kafka topic`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartlegging = sak.opprettKartlegging()
        val kartleggingSvarDto = kartlegging.sendKartleggingSvarTilKafka()

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe kartleggingSvarDto.spørreundersøkelseId
    }

    @Test
    fun `Skal ikke kunne svare på kartlegging som ikke eksisterer`() {
        val kartleggingSvarDto = sendKartleggingSvarTilKafka()

        TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldHaveSize 0
        TestContainerHelper.lydiaApiContainer.shouldContainLog("Fant ikke kartlegging på denne iden".toRegex())
    }

    @Test
    fun `skal oppdatere ved nytt svar mottatt på Kafka topic`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartleggingSvarDto =  sak.opprettKartlegging().sendKartleggingSvarTilKafka()

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select svar_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe kartleggingSvarDto.svarId

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select endret from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe null

        val nySvarId = UUID.randomUUID().toString()

        sendKartleggingSvarTilKafka(
            kartleggingId = kartleggingSvarDto.spørreundersøkelseId,
            spørsmålId = kartleggingSvarDto.spørsmålId,
            sesjonId = kartleggingSvarDto.sesjonId,
            svarId = nySvarId
        )

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select svar_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe nySvarId
        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select endret from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldNotBe null
    }

    @Test
    fun `skal oppdatere spørreundersøkelses kafkamelding ved nytt svar`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        runBlocking {
            TestContainerHelper.kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                    key = kartleggingDto.kartleggingId,
                    konsument = kartleggingKonsument
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SpørreundersøkelseDto>(melding)
                    spørreundersøkelse.status shouldBe KartleggingStatus.OPPRETTET
                    spørreundersøkelse.spørsmålOgSvaralternativer.first().antallSvar shouldBe 0
                }
            }
        }

        kartleggingDto.sendKartleggingSvarTilKafka()

        runBlocking {
            TestContainerHelper.kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                    key = kartleggingDto.kartleggingId,
                    konsument = kartleggingKonsument
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SpørreundersøkelseDto>(melding)
                    spørreundersøkelse.status shouldBe KartleggingStatus.OPPRETTET
                    spørreundersøkelse.spørsmålOgSvaralternativer.first().antallSvar shouldBe 1
                }
            }
        }
    }
}
