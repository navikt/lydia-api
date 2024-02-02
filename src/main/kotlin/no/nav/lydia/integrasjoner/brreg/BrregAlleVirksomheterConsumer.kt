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

object BrregAlleVirksomheterConsumer : CoroutineScope {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    private lateinit var job: Job
    private lateinit var kafka: Kafka

    private lateinit var virksomhetRepository: VirksomhetRepository
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>
    private val topicNavn = Topic.BRREG_ALLE_VIRKSOMHETER_TOPIC.navn
    private val consumerGroupId = Topic.BRREG_ALLE_VIRKSOMHETER_TOPIC.konsumentGruppe

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(BrregAlleVirksomheterConsumer::cancel))
    }

    fun create(kafka: Kafka, repository: VirksomhetRepository) {
        logger.info("Creating kafka consumer job for $topicNavn i group $consumerGroupId")
        job = Job()
        BrregAlleVirksomheterConsumer.kafka = kafka
        virksomhetRepository = repository
        kafkaConsumer = KafkaConsumer(
            BrregAlleVirksomheterConsumer.kafka.consumerProperties(consumerGroupId = consumerGroupId),
            StringDeserializer(),
            StringDeserializer()
        )
        logger.info("Created kafka consumer job for $topicNavn i group $consumerGroupId")
    }

    fun run() {
        launch {
            kafkaConsumer.use { consumer ->
                try {
                    consumer.subscribe(listOf(topicNavn))
                    logger.info("Kafka consumer subscribed to $topicNavn")
                    while (job.isActive) {
                        try {
                            val records = consumer.poll(Duration.ofSeconds(1))
                            val antallMeldinger = records.count()
                            if (antallMeldinger < 1) continue
                            var antallIrrelevanteBedrifter = 0
                            logger.info("Fant $antallMeldinger nye meldinger for $topicNavn}")
                            records.forEach { record ->
                                val brregVirksomhet = Json.decodeFromString<BrregVirksomhetDto>(record.value())

                                try {
                                    val virksomhet = brregVirksomhet.tilVirksomhet(
                                        status = VirksomhetStatus.AKTIV,
                                        oppdateringsId = null
                                    )
                                    virksomhetRepository.insertVirksomhet(virksomhet)
                                    virksomhetRepository.insertNæringsundergrupper(virksomhet)
                                } catch (e: UgyldigAdresseException) {
                                    antallIrrelevanteBedrifter += 1
                                }
                            }
                            logger.info("Lagret $antallMeldinger meldinger for $topicNavn")
                            if (antallIrrelevanteBedrifter > 0) {
                                logger.info("Fant $antallIrrelevanteBedrifter irrelevante bedrifter.")
                            }
                            consumer.commitSync()
                        } catch (e: RetriableException) {
                            logger.warn("Had a retriable exception for $topicNavn, retrying", e)
                        }
                        delay(kafka.consumerLoopDelay)
                    }
                } catch (e: WakeupException) {
                    logger.info("BrregAlleVirksomheterConsumer is shutting down...")
                } catch (e: Exception) {
                    logger.error("Exception is shutting down kafka listner for $topicNavn", e)
                    throw e
                }
            }
        }
    }

    private fun cancel() = runBlocking {
        logger.info("Stopping kafka consumer job for $topicNavn")
        kafkaConsumer.wakeup()
        job.cancelAndJoin()
        logger.info("Stopped kafka consumer job for $topicNavn")
    }
}
