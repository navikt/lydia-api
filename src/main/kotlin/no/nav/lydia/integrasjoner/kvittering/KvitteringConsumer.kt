package no.nav.lydia.integrasjoner.kvittering

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.SerializationException
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Topic
import no.nav.lydia.appstatus.Helse
import no.nav.lydia.appstatus.Helsesjekk
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringService
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.errors.WakeupException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import kotlin.coroutines.CoroutineContext
import kotlin.coroutines.cancellation.CancellationException

class KvitteringConsumer :
    CoroutineScope,
    Helsesjekk {
    private lateinit var job: Job
    private lateinit var kafka: Kafka
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>
    private lateinit var dokumentPubliseringService: DokumentPubliseringService
    private val topic = Topic.DOKUMENT_KVITTERING_TOPIC
    private val json = Json {
        ignoreUnknownKeys = true
    }

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(this::cancel))
    }

    fun create(
        kafka: Kafka,
        dokumentPubliseringService: DokumentPubliseringService,
    ) {
        logger.info("Creating kafka consumer job for topic '${topic.navn}' i groupId '${topic.konsumentGruppe}'")
        this.job = Job()
        this.kafka = kafka
        this.dokumentPubliseringService = dokumentPubliseringService
        this.kafkaConsumer = KafkaConsumer(
            this.kafka.consumerProperties(consumerGroupId = topic.konsumentGruppe),
            StringDeserializer(),
            StringDeserializer(),
        )
        logger.info("Created kafka consumer job for topic '${topic.navn}' i groupId '${topic.konsumentGruppe}'")
    }

    fun run() {
        launch {
            kafkaConsumer.use { consumer ->
                try {
                    consumer.subscribe(listOf(topic.navn))
                    logger.info("Kafka consumer subscribed to topic '${topic.navn}' of groupId '${topic.konsumentGruppe}' )' in $consumer")

                    while (job.isActive) {
                        try {
                            val records = consumer.poll(Duration.ofSeconds(1))
                            if (!records.isEmpty) {
                                try {
                                    val kvitteringer = records.mapNotNull {
                                        logger.info("mottok: ${it.value()}")
                                        try {
                                            json.decodeFromString<KvitteringDto>(it.value())
                                        } catch (e: SerializationException) {
                                            logger.error("Klarte ikke å dekode kvittering med nøkkel ${it.key()}", e)
                                            null
                                        } catch (e: IllegalArgumentException) {
                                            logger.error("Kvittering med nøkkel ${it.key()} er feil formatert", e)
                                            null
                                        }
                                    }.onEach { kvittering ->
                                        logger.info("Forsøker å lagre kvittering for dokument: ${kvittering.dokumentId}")
                                        dokumentPubliseringService.lagreKvittering(kvittering)
                                    }

                                    logger.info(
                                        "Behandlet ${kvitteringer.size} kvittering(er) i topic '${topic.navn}').",
                                    )
                                    consumer.commitSync()
                                } catch (e: Exception) {
                                    logger.warn("Fikk feilmelding ved lagring av kvittering; ${e.message}", e)
                                }
                            }
                        } catch (e: RetriableException) {
                            logger.warn("Had a retriable exception in $consumer (topic '${topic.navn}'), retrying", e)
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

    private fun isRunning() = job.isActive

    override fun helse() = if (isRunning()) Helse.UP else Helse.DOWN

    companion object {
        private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    }
}
