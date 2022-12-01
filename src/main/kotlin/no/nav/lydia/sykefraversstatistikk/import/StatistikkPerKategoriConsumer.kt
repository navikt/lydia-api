package no.nav.lydia.sykefraversstatistikk.import

import com.google.gson.GsonBuilder
import kotlinx.coroutines.*
import no.nav.lydia.Kafka
import no.nav.lydia.appstatus.Helse
import no.nav.lydia.appstatus.Helsesjekk
import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkService
import org.apache.kafka.clients.consumer.ConsumerRecords
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import kotlin.coroutines.CoroutineContext

object StatistikkPerKategoriConsumer : CoroutineScope, Helsesjekk {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    lateinit var job: Job
    lateinit var kafka: Kafka
    private lateinit var sykefraværsstatistikkService: SykefraværsstatistikkService

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(StatistikkPerKategoriConsumer::cancel))
    }

    fun create(kafka: Kafka, sykefraværsstatistikkService: SykefraværsstatistikkService) {
        logger.info("Creating kafka consumer job for ${Kafka.statistikkPerKategoriGroupId}")
        this.job = Job()
        this.sykefraværsstatistikkService = sykefraværsstatistikkService
        this.kafka = kafka
        logger.info("Created kafka consumer job for ${Kafka.statistikkPerKategoriGroupId}")
    }

    fun run() {
        launch {
            KafkaConsumer(
                kafka.consumerProperties(consumerGroupId = Kafka.statistikkPerKategoriGroupId),
                StringDeserializer(),
                StringDeserializer()
            ).use { consumer ->
                consumer.subscribe(
                    listOf(
                        kafka.statistikkLandTopic,
                        kafka.statistikkVirksomhetTopic
                    )
                )
                logger.info("Kafka consumer subscribed to ${kafka.statistikkLandTopic} and ${kafka.statistikkVirksomhetTopic}")

                while (job.isActive) {
                    try {
                        val records = consumer.poll(Duration.ofSeconds(1))
                        if (!records.isEmpty) {
                            sykefraværsstatistikkService.lagreSykefraværsstatistikkPerKategori(
                                records.toSykefraversstatistikkPerKategoriImportDto()
                            )
                        }
                    } catch (e: RetriableException) {
                        logger.warn("Had a retriable exception, retrying", e)
                    }
                    delay(kafka.consumerLoopDelay)
                }

            }
        }
    }

    fun cancel() {
        logger.info("Stopping kafka consumer job for ${Kafka.statistikkPerKategoriGroupId}")
        job.cancel()
        logger.info("Stopped kafka consumer job for ${Kafka.statistikkPerKategoriGroupId}")
    }

    private fun ConsumerRecords<String, String>.toSykefraversstatistikkPerKategoriImportDto(): List<SykefraversstatistikkPerKategoriImportDto> {
        val gson = GsonBuilder().create()
        return this.map {
            gson.fromJson(
                it.value(),
                SykefraversstatistikkPerKategoriImportDto::class.java
            )
        }
    }

    fun isRunning() = job.isActive

    override fun helse() = if (isRunning()) Helse.UP else Helse.DOWN
}
