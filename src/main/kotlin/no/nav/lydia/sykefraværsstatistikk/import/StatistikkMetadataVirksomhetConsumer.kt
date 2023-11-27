package no.nav.lydia.sykefraværsstatistikk.import

import com.google.gson.GsonBuilder
import kotlinx.coroutines.*
import no.nav.lydia.Kafka
import no.nav.lydia.appstatus.Helse
import no.nav.lydia.appstatus.Helsesjekk
import no.nav.lydia.sykefraværsstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraværsstatistikk.import.BehandletImportMetadataVirksomhet.Companion.tilBehandletImportMetadataVirksomhet
import org.apache.kafka.clients.consumer.ConsumerRecords
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.errors.WakeupException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import kotlin.coroutines.CoroutineContext

object StatistikkMetadataVirksomhetConsumer : CoroutineScope, Helsesjekk {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    private lateinit var job: Job
    private lateinit var kafka: Kafka
    private lateinit var sykefraværsstatistikkService: SykefraværsstatistikkService
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(StatistikkMetadataVirksomhetConsumer::cancel))
    }

    fun create(kafka: Kafka, sykefraværsstatistikkService: SykefraværsstatistikkService) {
        logger.info("Creating kafka consumer job i StatistikkMetadataVirksomhetConsumer")
        this.job = Job()
        this.sykefraværsstatistikkService = sykefraværsstatistikkService
        this.kafka = kafka
        this.kafkaConsumer = KafkaConsumer(
            StatistikkMetadataVirksomhetConsumer.kafka.consumerProperties(consumerGroupId = Kafka.statistikkMetadataVirksomhetGroupId),
            StringDeserializer(),
            StringDeserializer()
        )
        logger.info("Created kafka consumer job i StatistikkMetadataVirksomhetConsumer")
    }

    fun run() {
        launch {
            kafkaConsumer.use { consumer ->
                try {
                    consumer.subscribe(listOf(kafka.statistikkMetadataVirksomhetTopic))
                    logger.info("Kafka consumer subscribed to ${kafka.statistikkMetadataVirksomhetTopic} in StatistikkMetadataVirksomhetConsumer")

                    while (job.isActive) {
                        try {
                            val records = consumer.poll(Duration.ofSeconds(1))
                            if (!records.isEmpty) {
                                sykefraværsstatistikkService.lagreStatistikkMetadataVirksomhet(
                                    records.toSykefraværsstatistikkMetadataVirksomhetImportDto().tilBehandletImportMetadataVirksomhet()
                                )
                                logger.info("Lagret ${records.count()} meldinger om i StatistikkMetadataVirksomhetConsumer")
                                consumer.commitSync()
                            }
                        } catch (e: RetriableException) {
                            logger.warn("Had a retriable exception in StatistikkMetadataVirksomhetConsumer, retrying", e)
                        }
                        delay(kafka.consumerLoopDelay)
                    }
                } catch (e: WakeupException) {
                    logger.info("StatistikkMetadataVirksomhetConsumer is shutting down...")
                } catch (e: Exception) {
                    logger.error("Exception is shutting down kafka listner i StatistikkMetadataVirksomhetConsumer", e)
                    throw e
                }
            }
        }
    }

    private fun cancel() = runBlocking {
        logger.info("Stopping kafka consumer job i StatistikkMetadataVirksomhetConsumer")
        kafkaConsumer.wakeup()
        job.cancelAndJoin()
        logger.info("Stopped kafka consumer job i StatistikkMetadataVirksomhetConsumer")
    }

    private fun ConsumerRecords<String, String>.toSykefraværsstatistikkMetadataVirksomhetImportDto():
            List<SykefraværsstatistikkMetadataVirksomhetImportDto> {
        val gson = GsonBuilder().create()
        return this.map {
            gson.fromJson(
                it.value(),
                SykefraværsstatistikkMetadataVirksomhetImportDto::class.java
            )
        }
    }

    private fun isRunning() = job.isActive

    override fun helse() = if (isRunning()) Helse.UP else Helse.DOWN
}
