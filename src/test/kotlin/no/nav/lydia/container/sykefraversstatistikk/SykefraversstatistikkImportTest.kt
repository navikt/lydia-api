package no.nav.lydia.container.sykefraversstatistikk

import SykefraversstatistikkKafkaMelding
import com.github.kittinunf.fuel.gson.responseObject
import com.github.kittinunf.result.getOrElse
import com.google.gson.GsonBuilder
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.delay
import kotlinx.coroutines.runBlocking
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.withLydiaToken
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import org.apache.kafka.clients.producer.ProducerRecord
import kotlin.test.BeforeTest
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkImportTest {
    val postgres = TestContainerHelper.postgresContainer
    val lydiaApi = TestContainerHelper.lydiaApiContainer
    val kafkaHelper = TestContainerHelper.kafkaContainerHelper
    val gson = GsonBuilder().create()
    val producer = kafkaHelper.producer()
    val testOrgnr = "987654321"

    @Test
    fun `importerte data skal kunne hentes ut`() {
        runBlocking {
            val kafkaMelding = sykefraversstatistikkKafkaMelding()
            sendMeldingTilKafka(kafkaMelding)

            delay(2000)

            val result = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$testOrgnr")
                .withLydiaToken()
                .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third

            result.fold(success = { dtos ->
                dtos.size shouldBeExactly 1
                val dto = dtos[0]
                dto.orgnr shouldBeToStringEqualTo kafkaMelding.value.virksomhetSykefravær.orgnr
                dto.arstall shouldBeToStringEqualTo kafkaMelding.value.virksomhetSykefravær.arstall
                dto.kvartal shouldBeToStringEqualTo kafkaMelding.value.virksomhetSykefravær.kvartal
                dto.sykefraversprosent shouldBeToStringEqualTo kafkaMelding.value.virksomhetSykefravær.sykefraversprosent
                dto.antallPersoner shouldBeToStringEqualTo kafkaMelding.value.virksomhetSykefravær.antallPersoner
                dto.muligeDagsverk shouldBeToStringEqualTo kafkaMelding.value.virksomhetSykefravær.muligeDagsverk
                dto.tapteDagsverk shouldBeToStringEqualTo kafkaMelding.value.virksomhetSykefravær.tapteDagsverk
            }, failure = {
                fail(it.message)
            })
        }
    }

    @Test
    fun `import av data er idempotent`() {
        runBlocking {
            sendMeldingTilKafka()
            delay(2000)

            val førsteLagredeVStatistikk = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$testOrgnr")
                .withLydiaToken()
                .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
                .getOrElse { fail(it.message) }

            sendMeldingTilKafka()
            delay(2000)

            val second = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$testOrgnr")
                .withLydiaToken()
                .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third

            second.fold(success = { dtos ->
                dtos.size shouldBeExactly 1
                val dto = dtos[0]
                dto.orgnr shouldBeToStringEqualTo førsteLagredeVStatistikk[0].orgnr
                dto.arstall shouldBeToStringEqualTo førsteLagredeVStatistikk[0].arstall
                dto.kvartal shouldBeToStringEqualTo førsteLagredeVStatistikk[0].kvartal
                dto.sykefraversprosent shouldBeToStringEqualTo førsteLagredeVStatistikk[0].sykefraversprosent
                dto.antallPersoner shouldBeToStringEqualTo førsteLagredeVStatistikk[0].antallPersoner
                dto.muligeDagsverk shouldBeToStringEqualTo førsteLagredeVStatistikk[0].muligeDagsverk
                dto.tapteDagsverk shouldBeToStringEqualTo førsteLagredeVStatistikk[0].tapteDagsverk
            }, failure = {
                fail(it.message)
            })
        }
    }

    private fun sendMeldingTilKafka(kafkaMelding: SykefraversstatistikkKafkaMelding? = sykefraversstatistikkKafkaMelding()) {
        producer.send(
            ProducerRecord(
                kafkaHelper.statistikkTopic,
                gson.toJson(kafkaMelding?.key),
                gson.toJson(kafkaMelding?.value)
            )
        ).get()
    }

    private fun sykefraversstatistikkKafkaMelding(): SykefraversstatistikkKafkaMelding {
        val jsonFromResources = this::class.java.getResource("/sykefraværsstatistikk_kafka_melding.json").readText()
        return gson.fromJson(jsonFromResources, SykefraversstatistikkKafkaMelding::class.java)
    }

    infix fun String.shouldBeToStringEqualTo(other: Any) {
        this shouldBe other.toString()
    }
}

