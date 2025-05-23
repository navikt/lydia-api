package no.nav.lydia.integrasjoner.brreg

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Topic
import no.nav.lydia.exceptions.UgyldigAdresseException
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.errors.WakeupException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import kotlin.coroutines.CoroutineContext
import kotlin.coroutines.cancellation.CancellationException

object BrregAlleVirksomheterConsumer : CoroutineScope {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    private lateinit var job: Job
    private lateinit var kafka: Kafka

    private lateinit var virksomhetRepository: VirksomhetRepository
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>
    private val topic = Topic.BRREG_ALLE_VIRKSOMHETER_TOPIC

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(BrregAlleVirksomheterConsumer::cancel))
    }

    fun create(
        kafka: Kafka,
        repository: VirksomhetRepository,
    ) {
        logger.info("Creating kafka consumer job for ${topic.navn} i group ${topic.konsumentGruppe}")
        job = Job()
        BrregAlleVirksomheterConsumer.kafka = kafka
        virksomhetRepository = repository
        kafkaConsumer = KafkaConsumer(
            BrregAlleVirksomheterConsumer.kafka.consumerProperties(consumerGroupId = topic.konsumentGruppe),
            StringDeserializer(),
            StringDeserializer(),
        )
        logger.info("Created kafka consumer job for ${topic.navn} i group ${topic.konsumentGruppe}")
    }

    fun run() {
        launch {
            kafkaConsumer.use { consumer ->
                try {
                    consumer.subscribe(listOf(topic.navn))
                    logger.info("Kafka consumer subscribed to ${topic.navn}")
                    while (job.isActive) {
                        try {
                            val records = consumer.poll(Duration.ofSeconds(1))
                            val antallMeldinger = records.count()
                            if (antallMeldinger < 1) continue
                            var antallIrrelevanteBedrifter = 0
                            logger.info("Fant $antallMeldinger nye meldinger for ${topic.navn}}")
                            records.forEach { record ->
                                val brregVirksomhet = Json.decodeFromString<BrregVirksomhetDto>(record.value())

                                try {
                                    val virksomhet = brregVirksomhet.tilVirksomhet(
                                        status = VirksomhetStatus.AKTIV,
                                        oppdateringsId = null,
                                    )
                                    virksomhetRepository.insertVirksomhet(virksomhet)
                                    virksomhetRepository.insertNæringsundergrupper(virksomhet)
                                } catch (_: UgyldigAdresseException) {
                                    antallIrrelevanteBedrifter += 1
                                }
                            }
                            logger.info("Lagret $antallMeldinger meldinger for ${topic.navn}")
                            if (antallIrrelevanteBedrifter > 0) {
                                logger.info("Fant $antallIrrelevanteBedrifter irrelevante bedrifter.")
                            }
                            consumer.commitSync()
                        } catch (e: RetriableException) {
                            logger.warn("Had a retriable exception for ${topic.navn}, retrying", e)
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
}
