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
    lateinit var naisEnvironment: NaisEnvironment

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job
    
    init {
        Runtime.getRuntime().addShutdownHook(Thread(StatistikkConsumer::cancel))
    }

    fun create(naisEnv: NaisEnvironment) {
        this.job = Job()
        this.naisEnvironment = naisEnv
    }

    fun run() {
        launch {
            KafkaConsumer(
                naisEnvironment.kafka.consumerConfig(),
                StringDeserializer(),
                StringDeserializer()
            ).use { consumer ->
                consumer.subscribe(listOf(Kafka.statistikkTopic))

                while (job.isActive) {
                    try {
                        val records = consumer.poll(Duration.of(100, ChronoUnit.MILLIS))
                        records.forEach { logger.info("""
                            \n\n FROM KAFKA \n
                            ${it.value()}
                            \n\n
                            """.trimIndent()) }

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
        job.cancel()
    }
}