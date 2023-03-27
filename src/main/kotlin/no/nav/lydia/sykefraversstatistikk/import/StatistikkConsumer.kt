package no.nav.lydia.sykefraversstatistikk.import

import com.google.gson.GsonBuilder
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import no.nav.lydia.Kafka
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.appstatus.Helse
import no.nav.lydia.appstatus.Helsesjekk
import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraversstatistikk.import.BehandletImportStatistikk.Companion.tilBehandletStatistikk
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

    lateinit var sykefraværsstatistikkService: SykefraværsstatistikkService

    val naisEnv = NaisEnvironment()

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
                        logger.info("Fant ${records.count()} nye ${kafka.statistikkTopic} meldinger")
                        if (naisEnv.miljø == NaisEnvironment.Companion.Environment.`DEV-GCP`) {
                            records.forEach { logger.info("DEBUG: Record key: ${it.key()} value: ${it.value()}") }
                        }
                        // TODO: Feilhåndtering (og alarmering?)
                        sykefraværsstatistikkService.lagre(
                            sykefraværsstatistikkListe =
                            records.toSykefraversstatistikkImportDto().tilBehandletStatistikk()
                        )
                        logger.info("Lagret ${records.count()} ${kafka.statistikkTopic} meldinger")

                        consumer.commitSync()
                    } catch (e: RetriableException) {
                        logger.warn("Had a retriable exception for ${kafka.statistikkTopic} topic, retrying", e)
                    } catch (e: Exception) {
                        logger.error("Exception is shutting down kafka listner for ${kafka.statistikkTopic}", e)
                        job.cancel(CancellationException(e.message))
                        throw e
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
