package no.nav.lydia.sykefraversstatistikk.import

import com.google.gson.GsonBuilder
import kotlinx.coroutines.*
import no.nav.lydia.Kafka
import no.nav.lydia.appstatus.Helse
import no.nav.lydia.appstatus.Helsesjekk
import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkService
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

object StatistikkPerKategoriConsumer : CoroutineScope, Helsesjekk {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    lateinit var job: Job
    lateinit var kafka: Kafka
    private lateinit var sykefraværsstatistikkService: SykefraværsstatistikkService
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(StatistikkPerKategoriConsumer::cancel))
    }

    fun create(kafka: Kafka, sykefraværsstatistikkService: SykefraværsstatistikkService) {
        logger.info("Creating kafka consumer job i StatistikkPerKategoriConsumer")
        this.job = Job()
        this.sykefraværsstatistikkService = sykefraværsstatistikkService
        this.kafka = kafka
        this.kafkaConsumer = KafkaConsumer(
            StatistikkPerKategoriConsumer.kafka.consumerProperties(consumerGroupId = Kafka.statistikkPerKategoriGroupId),
            StringDeserializer(),
            StringDeserializer()
        )
        logger.info("Created kafka consumer job i StatistikkPerKategoriConsumer")
    }

    fun run() {
        launch {
            kafkaConsumer.use { consumer ->
                try {
                    consumer.subscribe(
                        listOf(
                            kafka.statistikkLandTopic,
                            kafka.statistikkSektorTopic,
                            kafka.statistikkNæringTopic,
                            kafka.statistikkNæringskodeTopic,
                            kafka.statistikkVirksomhetTopic
                        )
                    )
                    logger.info("Kafka consumer subscribed to ${kafka.statistikkLandTopic}, ${kafka.statistikkSektorTopic} " +
                            "${kafka.statistikkNæringTopic}, ${kafka.statistikkNæringskodeTopic} " +
                            "and ${kafka.statistikkVirksomhetTopic} in StatistikkPerKategoriConsumer")

                    while (job.isActive) {
                        try {
                            val records = consumer.poll(Duration.ofSeconds(1))
                            if (!records.isEmpty) {
                                sykefraværsstatistikkService.lagreSykefraværsstatistikkPerKategori(
                                    records.toSykefraversstatistikkPerKategoriImportDto()
                                )
                                logger.info("Lagret ${records.count()} meldinger om i StatistikkPerKategoriConsumer per kategori")
                                consumer.commitSync()
                            }
                        } catch (e: RetriableException) {
                            logger.warn("Had a retriable exception in StatistikkPerKategoriConsumer, retrying", e)
                        }
                        delay(kafka.consumerLoopDelay)
                    }
                } catch (e: WakeupException) {
                    logger.info("StatistikkPerKategoriConsumer is shutting down...")
                } catch (e: Exception) {
                    logger.error("Exception is shutting down kafka listner i StatistikkPerKategoriConsumer", e)
                    throw e
                }
            }
        }
    }

    fun cancel() = runBlocking {
        logger.info("Stopping kafka consumer job i StatistikkPerKategoriConsumer")
        kafkaConsumer.wakeup()
        job.cancelAndJoin()
        logger.info("Stopped kafka consumer job i StatistikkPerKategoriConsumer")
    }

    private fun ConsumerRecords<String, String>.toSykefraversstatistikkPerKategoriImportDto(): List<SykefraversstatistikkPerKategoriImportDto> {
        val gson = GsonBuilder().create()
        return this.filter { erMeldingenGyldig(it) }.map {
            gson.fromJson(
                it.value(),
                SykefraversstatistikkPerKategoriImportDto::class.java
            )
        }
    }

    private fun erMeldingenGyldig(consumerRecord: ConsumerRecord<String, String>): Boolean {
        val gson = GsonBuilder().create()
        val key = gson.fromJson(consumerRecord.key(), KeySykefraversstatistikkPerKategori::class.java)

        return if (Kategori.values().map { it.name }.contains( key.kategori) && key.kode.isNotEmpty()) {
            true
        } else {
            logger.warn("Feil formatert Kafka melding i topic ${consumerRecord.topic()} for key ${consumerRecord.key().trim()}")
            false
        }
    }

    fun isRunning() = job.isActive

    override fun helse() = if (isRunning()) Helse.UP else Helse.DOWN
}
