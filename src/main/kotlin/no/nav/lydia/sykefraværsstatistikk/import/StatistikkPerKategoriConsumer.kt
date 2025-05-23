package no.nav.lydia.sykefraværsstatistikk.import

import com.google.gson.GsonBuilder
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import no.nav.lydia.Kafka
import no.nav.lydia.Topic
import no.nav.lydia.appstatus.Helse
import no.nav.lydia.appstatus.Helsesjekk
import no.nav.lydia.sykefraværsstatistikk.SykefraværsstatistikkService
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
import kotlin.coroutines.cancellation.CancellationException

class StatistikkPerKategoriConsumer(
    val topic: Topic,
) : CoroutineScope,
    Helsesjekk {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    private lateinit var job: Job
    private lateinit var kafka: Kafka
    private lateinit var sykefraværsstatistikkService: SykefraværsstatistikkService
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(this::cancel))
    }

    fun create(
        kafka: Kafka,
        sykefraværsstatistikkService: SykefraværsstatistikkService,
    ) {
        logger.info("Creating kafka consumer job i StatistikkPerKategoriConsumer i groupId '${topic.konsumentGruppe}'")
        this.job = Job()
        this.sykefraværsstatistikkService = sykefraværsstatistikkService
        this.kafka = kafka
        this.kafkaConsumer = KafkaConsumer(
            this.kafka.consumerProperties(consumerGroupId = topic.konsumentGruppe),
            StringDeserializer(),
            StringDeserializer(),
        )
        logger.info("Created kafka consumer job i StatistikkPerKategoriConsumer i groupId '${topic.konsumentGruppe}'")
    }

    fun run() {
        launch {
            kafkaConsumer.use { consumer ->
                try {
                    consumer.subscribe(listOf(topic.navn))
                    logger.info(
                        "Kafka consumer subscribed to topic '$topic' of groupId '${topic.konsumentGruppe}' )' in StatistikkPerKategoriConsumer",
                    )

                    while (job.isActive) {
                        try {
                            val records = consumer.poll(Duration.ofSeconds(1))
                            if (!records.isEmpty) {
                                sykefraværsstatistikkService.lagreSykefraværsstatistikkPerKategori(
                                    records.toSykefravPerKategoriImportDto(),
                                )
                                logger.info("Lagret ${records.count()} meldinger i StatistikkPerKategoriConsumer (topic '$topic') ")
                                consumer.commitSync()
                            }
                        } catch (e: RetriableException) {
                            logger.warn(
                                "Had a retriable exception in StatistikkPerKategoriConsumer (topic '$topic'), retrying",
                                e,
                            )
                        }
                        delay(kafka.consumerLoopDelay)
                    }
                } catch (e: WakeupException) {
                    logger.info("$consumer (topic '${topic.navn}')  is waking up", e)
                } catch (e: CancellationException) {
                    logger.info("$consumer (topic '${topic.navn}')  is shutting down...", e)
                } catch (e: Exception) {
                    logger.error("Exception is shutting down kafka listener $consumer (topic '${topic.navn}')", e)
                    throw e
                }
            }
        }
    }

    private fun cancel() =
        runBlocking {
            logger.info("Stopping kafka consumer job for topic '${topic.navn}'")
            kafkaConsumer.wakeup()
            job.cancelAndJoin()
            logger.info("Stopped kafka consumer job for topic '${topic.navn}'")
        }

    private fun ConsumerRecords<String, String>.toSykefravPerKategoriImportDto(): List<SykefraværsstatistikkPerKategoriImportDto> {
        val gson = GsonBuilder().create()
        return this.filter { erMeldingenGyldig(it) }.map {
            gson.fromJson(
                it.value(),
                SykefraværsstatistikkPerKategoriImportDto::class.java,
            )
        }
    }

    private fun erMeldingenGyldig(consumerRecord: ConsumerRecord<String, String>): Boolean {
        val gson = GsonBuilder().create()
        val key = gson.fromJson(consumerRecord.key(), KeySykefraværsstatistikkPerKategori::class.java)

        return if (Kategori.entries.map { it.name }.contains(key.kategori) && key.kode.isNotEmpty()) {
            true
        } else {
            logger.warn(
                "Feil formatert Kafka melding i topic ${consumerRecord.topic()} for key ${
                    consumerRecord.key().trim()
                }",
            )
            false
        }
    }

    private fun isRunning() = job.isActive

    override fun helse() = if (isRunning()) Helse.UP else Helse.DOWN
}
