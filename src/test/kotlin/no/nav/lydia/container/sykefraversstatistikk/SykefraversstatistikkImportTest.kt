package no.nav.lydia.container.sykefraversstatistikk

import SykefraversstatistikkKafkaMelding
import com.github.kittinunf.fuel.gson.responseObject
import com.google.gson.GsonBuilder
import io.kotest.matchers.equality.shouldBeEqualToComparingFields
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.withLydiaToken
import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto.Companion.toDto
import org.apache.kafka.clients.producer.ProducerRecord
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkImportTest {
    val postgres = TestContainerHelper.postgresContainer
    val lydiaApi = TestContainerHelper.lydiaApiContainer
    val kafkaHelper = TestContainerHelper.kafkaContainerHelper
    val sykefraversstatistikkRepository = SykefraversstatistikkRepository(postgres.getDataSource())
    val gson = GsonBuilder().create()

    @Test
    fun `importerte data skal kunne hentes ut`() {
        val jsonFromResources = this::class.java.getResource("/sykefraværsstatistikk_kafka_melding.json").readText()
        val kafkaMelding = gson.fromJson(jsonFromResources, SykefraversstatistikkKafkaMelding::class.java)

        val producer = kafkaHelper.producer()
        producer.send(ProducerRecord(kafkaHelper.statistikkTopic, gson.toJson(kafkaMelding.key), gson.toJson(kafkaMelding.value))).get()

        // TODO finn bedre løsning enn Thread.sleep?
        Thread.sleep(5000)

        // Hent ut sykefraværsstatistikk
        val testOrgnr = "987654321"
        val sykefravær = sykefraversstatistikkRepository.hentSykefravær(testOrgnr)
        sykefravær.size shouldBe 1

         val result = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$testOrgnr")
             .withLydiaToken()
             .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third

        result.fold(success = { dto ->
            dto.size shouldBeExactly 1
            dto[0] shouldBeEqualToComparingFields sykefravær[0].toDto()
        }, failure = {
            fail(it.message)
        })
    }

}

