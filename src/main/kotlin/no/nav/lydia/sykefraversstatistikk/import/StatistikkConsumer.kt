package no.nav.lydia.sykefraversstatistikk.import

import com.google.gson.GsonBuilder
import kotlinx.coroutines.*
import no.nav.lydia.Kafka
import no.nav.lydia.appstatus.Helse
import no.nav.lydia.appstatus.Helsesjekk
import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraversstatistikk.import.BehandletImportStatistikk.Companion.tilBehandletStatistikk
import org.apache.kafka.clients.consumer.ConsumerRecord
import org.apache.kafka.clients.consumer.ConsumerRecords
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.errors.WakeupException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import kotlin.coroutines.CoroutineContext

object StatistikkConsumer : CoroutineScope, Helsesjekk {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    lateinit var job: Job
    lateinit var kafka: Kafka
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>

    lateinit var sykefraværsstatistikkService: SykefraværsstatistikkService

    val gson = GsonBuilder().create()
    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(StatistikkConsumer::cancel))
    }

    fun create(kafka: Kafka, sykefraværsstatistikkService: SykefraværsstatistikkService) {
        logger.info("Creating kafka consumer job for ${kafka.statistikkTopic}")
        this.job = Job()
        this.kafka = kafka
        this.sykefraværsstatistikkService = sykefraværsstatistikkService
        this.kafkaConsumer = KafkaConsumer(
            StatistikkConsumer.kafka.consumerProperties(),
            StringDeserializer(),
            StringDeserializer()
        )
        logger.info("Created kafka consumer job for ${kafka.statistikkTopic}")
    }

    fun run() {
        launch {
            kafkaConsumer.use { consumer ->
                try {
                    consumer.subscribe(listOf(kafka.statistikkTopic))
                    logger.info("Kafka consumer subscribed to ${kafka.statistikkTopic}")
                    while (job.isActive) {
                        try {
                            val records = consumer.poll(Duration.ofSeconds(1))
                            if (records.count() < 1) continue
                            logger.info("Fant ${records.count()} nye ${kafka.statistikkTopic} meldinger")
                            sykefraværsstatistikkService.lagre(
                                sykefraværsstatistikkListe =
                                records.toSykefraversstatistikkImportDto().tilBehandletStatistikk()
                            )
                            logger.info("Lagret ${records.count()} ${kafka.statistikkTopic} meldinger")

                            consumer.commitSync()
                        } catch (e: RetriableException) {
                            logger.warn("Had a retriable exception for ${kafka.statistikkTopic} topic, retrying", e)
                        }
                        delay(kafka.consumerLoopDelay)
                    }
                } catch (e: WakeupException) {
                    logger.info("StatistikkConsumer is shutting down...")
                } catch (e: Exception) {
                    logger.error("Exception is shutting down kafka listner for ${kafka.statistikkTopic}", e)
                    throw e
                }
            }
        }
    }

    private fun ConsumerRecords<String, String>.toSykefraversstatistikkImportDto(): List<SykefraversstatistikkImportDto> {
        return this.filter { erMeldingenGyldig(it) }.map {
            gson.fromJson(
                it.value(),
                SykefraversstatistikkImportDto::class.java
            )
        }
    }

    private fun erMeldingenGyldig(consumerRecord: ConsumerRecord<String, String>): Boolean {
        val key = gson.fromJson(consumerRecord.key(), Key::class.java)

        return if (key.orgnr?.length == 9) {
            true
        } else {
            logger.warn("Feil formatert Kafka melding i topic ${kafka.statistikkTopic} for key ${consumerRecord.key()}")
            false
        }
    }

    fun isRunning(): Boolean {
        logger.trace("Asked if running")
        return job.isActive
    }

    fun cancel() = runBlocking {
        logger.info("Stopping kafka consumer job for ${kafka.statistikkTopic}")
        kafkaConsumer.wakeup()
        job.cancelAndJoin()
        logger.info("Stopped kafka consumer job for ${kafka.statistikkTopic}")
    }

    override fun helse() = if (isRunning()) Helse.UP else Helse.DOWN
}
