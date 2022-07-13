package no.nav.lydia.sykefraversstatistikk.import

import com.google.gson.GsonBuilder
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
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

object StatistikkConsumer : CoroutineScope, Helsesjekk {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    lateinit var job: Job
    lateinit var kafka: Kafka

    // TODO: Er det greit å holde en datasource oppe i en coroutine scope?
    lateinit var sykefraværsstatistikkService: SykefraværsstatistikkService

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(StatistikkConsumer::cancel))
    }

    fun create(kafka: Kafka, sykefraværsstatistikkService: SykefraværsstatistikkService) {
        logger.info("Creating kafka consumer job for statistikk")
        this.job = Job()
        this.kafka = kafka
        this.sykefraværsstatistikkService = sykefraværsstatistikkService
        logger.info("Created kafka consumer job for statistikk")
    }

    fun run() {
        launch {
            KafkaConsumer(
                kafka.consumerProperties(),
                StringDeserializer(),
                StringDeserializer()
            ).use { consumer ->
                consumer.subscribe(listOf(kafka.statistikkTopic))
                logger.info("Kafka consumer subscribed to ${kafka.statistikkTopic}")

                while (job.isActive) {
                    try {
                        val records = consumer.poll(Duration.ofSeconds(1))
                        if (records.count() < 1) continue
                        logger.info("Fant ${records.count()} nye meldinger")
                        // TODO: Feilhåndtering (og alarmering?)
                        sykefraværsstatistikkService.lagre(sykefraværsstatistikkListe = records.toSykefraversstatistikkImportDto())
                        logger.info("Lagret ${records.count()} meldinger")

                        consumer.commitSync()
                    } catch (e: RetriableException) {
                        logger.warn("Had a retriable exception, retrying", e)
                    }
                    delay(kafka.consumerLoopDelay)
                }

            }
        }
    }

    private fun ConsumerRecords<String, String>.toSykefraversstatistikkImportDto(): List<SykefraversstatistikkImportDto> {
        val gson = GsonBuilder().create()
        return this.map {
            gson.fromJson(
                it.value(),
                SykefraversstatistikkImportDto::class.java
            )
        }
    }

    fun isRunning(): Boolean {
        logger.trace("Asked if running")
        return job.isActive
    }

    fun cancel() {
        logger.info("Stopping kafka consumer job for statistikk")
        job.cancel()
        logger.info("Stopped kafka consumer job for statistikk")
    }

    override fun helse() = if (isRunning()) Helse.UP else Helse.DOWN
}
