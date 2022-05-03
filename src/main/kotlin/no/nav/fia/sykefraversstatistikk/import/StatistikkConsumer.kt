package no.nav.fia.sykefraversstatistikk.import

import SykefraversstatistikkImportDto
import com.google.gson.GsonBuilder
import kotlinx.coroutines.*
import no.nav.fia.Kafka
import no.nav.fia.sykefraversstatistikk.SykefraversstatistikkRepository
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import kotlin.coroutines.CoroutineContext

object StatistikkConsumer : CoroutineScope {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    private val BULK_SIZE = 50
    lateinit var job: Job
    lateinit var kafka: Kafka

    // TODO: Er det greit å holde en datasource oppe i en coroutine scope?
    lateinit var sykefraversstatistikkRepository: SykefraversstatistikkRepository

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(StatistikkConsumer::cancel))
    }

    fun create(kafka: Kafka, sykefraversstatistikkRepository: SykefraversstatistikkRepository) {
        logger.info("Creating kafka consumer job")
        this.job = Job()
        this.kafka = kafka
        this.sykefraversstatistikkRepository = sykefraversstatistikkRepository
        logger.info("Created kafka consumer job")
    }

    fun run() {
        val gson = GsonBuilder().create()
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
                        if (records.count() > 0){
                            logger.info("Fant ${records.count()} nye meldinger")
                        }
                        records.map {
                            gson.fromJson(
                                it.value(),
                                SykefraversstatistikkImportDto::class.java
                            )
                        }.chunked(size = BULK_SIZE).forEach { sykefraværsStatistikkListe ->
                            // TODO: Feilhåndtering (og alarmering?)
                            sykefraversstatistikkRepository.insert(sykefraværsStatistikkListe = sykefraværsStatistikkListe)
                            logger.info("Lagret ${sykefraværsStatistikkListe.count()} meldinger")
                        }

                        consumer.commitSync()
                    } catch (e: RetriableException) {
                        logger.warn("Had a retriable exception, retrying", e)
                    }

                    delay(kafka.consumerLoopDelay)
                }

            }
        }
    }

    fun isRunning(): Boolean {
        logger.trace("Asked if running")
        return job.isActive
    }

    fun cancel() {
        logger.info("Stopping kafka consumer job")
        job.cancel()
        logger.info("Stopped kafka consumer job")
    }
}