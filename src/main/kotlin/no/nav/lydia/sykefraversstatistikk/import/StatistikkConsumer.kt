package no.nav.lydia.sykefraversstatistikk.import

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import no.nav.lydia.Kafka
import no.nav.lydia.NaisEnvironment
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import java.time.temporal.ChronoUnit
import kotlin.coroutines.CoroutineContext

object StatistikkConsumer : CoroutineScope {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    lateinit var job: Job
    lateinit var kafka: Kafka

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(StatistikkConsumer::cancel))
    }

    fun create(kafka: Kafka) {
        logger.info("Creating kafka consumer job")
        this.job = Job()
        this.kafka = kafka
        logger.info("Created kafka consumer job")
    }

    fun run() {
        launch {
            KafkaConsumer(
                kafka.consumerConfig(),
                StringDeserializer(),
                StringDeserializer()
            ).use { consumer ->
                consumer.subscribe(listOf(Kafka.statistikkTopic))
                logger.info("Kafka consumer subscribed to ${Kafka.statistikkTopic}")
                while (job.isActive) {
                    try {
                        val records = consumer.poll(Duration.ofMinutes(1))
                        logger.info("Fant ${records.count()} nye meldinger")
                        consumer.commitSync()
                    } catch (e: RetriableException) {
                        logger.warn("Had a retriable exception, retrying", e)
                    }
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