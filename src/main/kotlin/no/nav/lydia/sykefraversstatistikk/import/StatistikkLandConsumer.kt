package no.nav.lydia.sykefraversstatistikk.import

import kotlinx.coroutines.*
import no.nav.lydia.Kafka
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import kotlin.coroutines.CoroutineContext

object StatistikkLandConsumer : CoroutineScope {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    lateinit var job: Job
    lateinit var kafka: Kafka

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(StatistikkLandConsumer::cancel))
    }

    fun create(kafka: Kafka) {
        logger.info("Creating kafka consumer job for statistikk")
        this.job = Job()
        this.kafka = kafka
        logger.info("Created kafka consumer job for statistikk")
    }

    fun run() {
        launch {
            KafkaConsumer(
                kafka.consumerProperties(consumerGroupId = Kafka.statistikkNyConsumerGroupId),
                StringDeserializer(),
                StringDeserializer()
            ).use { consumer ->
                consumer.subscribe(listOf(
                    kafka.statistikkLandTopic,
                    kafka.statistikkVirksomhetTopic
                ))
                logger.info("Kafka consumer subscribed to ${kafka.statistikkLandTopic} and ${kafka.statistikkVirksomhetTopic}")

                while (job.isActive) {
                    try {
                        val records = consumer.poll(Duration.ofSeconds(1))
                        records.iterator()
                            .forEach { logger.info("Topic: ${it.topic()} - Melding: ${it.key()}: ${it.value()}") }
                    } catch (e: RetriableException) {
                        logger.warn("Had a retriable exception, retrying", e)
                    }
                    delay(kafka.consumerLoopDelay)
                }

            }
        }
    }

    fun cancel() {
        logger.info("Stopping kafka consumer job for statistikk")
        job.cancel()
        logger.info("Stopped kafka consumer job for statistikk")
    }
}
