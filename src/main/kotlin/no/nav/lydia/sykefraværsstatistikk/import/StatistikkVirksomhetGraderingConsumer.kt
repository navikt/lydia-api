package no.nav.lydia.sykefraværsstatistikk.import

import com.google.gson.GsonBuilder
import kotlinx.coroutines.*
import no.nav.lydia.Kafka
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

object StatistikkVirksomhetGraderingConsumer : CoroutineScope, Helsesjekk  {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    private lateinit var job: Job
    private lateinit var kafka: Kafka
    private lateinit var sykefraværsstatistikkService: SykefraværsstatistikkService
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>
    private lateinit var topic: String
    private var groupId = Kafka.statistikkVirksomhetGraderingGroupId

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(this::cancel))
    }

    fun create(kafka: Kafka, sykefraværsstatistikkService: SykefraværsstatistikkService) {
        logger.info("Creating kafka consumer job i StatistikkVirksomhetGraderingConsumer i groupId '$groupId'")
        this.job = Job()
        this.sykefraværsstatistikkService = sykefraværsstatistikkService
        this.kafka = kafka
        this.topic = kafka.statistikkVirksomhetGraderingTopic
        this.kafkaConsumer = KafkaConsumer(
            this.kafka.consumerProperties(consumerGroupId = groupId),
            StringDeserializer(),
            StringDeserializer()
        )
        logger.info("Created kafka consumer job i StatistikkVirksomhetGraderingConsumer i groupId '$groupId'")
    }

    fun run() {
        launch {
            kafkaConsumer.use { consumer ->
                try {
                    consumer.subscribe(listOf(topic))
                    logger.info("Kafka consumer subscribed to topic '$topic' of groupId '$groupId' )' in StatistikkVirksomhetGraderingConsumer")

                    while (job.isActive) {
                        try {
                            val records = consumer.poll(Duration.ofSeconds(1))
                            if (!records.isEmpty) {
                                sykefraværsstatistikkService.lagreStatistikkVirksomhetGradering(
                                   records.tilGradertSykemeldingImportDto()
                                )
                                logger.info("Lagret ${records.count()} meldinger i StatistikkVirksomhetGraderingConsumer (topic '$topic') ")
                                consumer.commitSync()
                            }
                        } catch (e: RetriableException) {
                            logger.warn("Had a retriable exception in StatistikkVirksomhetGraderingConsumer (topic '$topic'), retrying", e)
                        }
                        delay(kafka.consumerLoopDelay)
                    }
                } catch (e: WakeupException) {
                    logger.info("StatistikkVirksomhetGraderingConsumer (topic '$topic')  is shutting down...")
                } catch (e: Exception) {
                    logger.error("Exception is shutting down kafka listner i StatistikkVirksomhetGraderingConsumer (topic '$topic')", e)
                    throw e
                }
            }
        }
    }

    private fun cancel() = runBlocking {
        logger.info("Stopping kafka consumer job i StatistikkVirksomhetGraderingConsumer (topic '$topic')")
        kafkaConsumer.wakeup()
        job.cancelAndJoin()
        logger.info("Stopped kafka consumer job i StatistikkVirksomhetGraderingConsumer (topic '$topic')")
    }

    private fun ConsumerRecords<String, String>.tilGradertSykemeldingImportDto(): List<GradertSykemeldingImportDto> {
        val gson = GsonBuilder().create()
        return this.filter { erMeldingenGyldig(it) }.map {
            gson.fromJson(
                it.value(),
                GradertSykemeldingImportDto::class.java
            )
        }.filter {
            (it.siste4Kvartal.tapteDagsverk != null
                    && it.siste4Kvartal.tapteDagsverkGradert != null
                    && it.sistePubliserteKvartal.tapteDagsverk != null
                    && it.sistePubliserteKvartal.tapteDagsverkGradert != null)
        }
    }

    private fun erMeldingenGyldig(consumerRecord: ConsumerRecord<String, String>): Boolean {
        val gson = GsonBuilder().create()
        val key = gson.fromJson(consumerRecord.key(), KeySykefraværsstatistikkPerKategori::class.java)

        return if (key.kategori == "VIRKSOMHET_GRADERT" && key.kode.isNotEmpty()) {
            true
        } else {
            logger.warn("Feil formatert Kafka melding i topic ${consumerRecord.topic()} for key ${consumerRecord.key().trim()}")
            false
        }
    }

    private fun isRunning() = job.isActive

    override fun helse() = if (isRunning()) Helse.UP else Helse.DOWN
}
