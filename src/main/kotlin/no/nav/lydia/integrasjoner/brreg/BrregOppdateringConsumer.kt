package no.nav.lydia.integrasjoner.brreg

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.Instant
import kotlinx.serialization.Serializable
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

object BrregOppdateringConsumer : CoroutineScope {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    private lateinit var job: Job
    private lateinit var kafka: Kafka

    private lateinit var repository: VirksomhetRepository
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>
    private val topic = Topic.BRREG_OPPDATERING_TOPIC

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(BrregOppdateringConsumer::cancel))
    }

    fun create(
        kafka: Kafka,
        repository: VirksomhetRepository,
    ) {
        logger.info("Creating kafka consumer job for ${topic.navn}")
        job = Job()
        BrregOppdateringConsumer.kafka = kafka
        BrregOppdateringConsumer.repository = repository
        kafkaConsumer = KafkaConsumer(
            BrregOppdateringConsumer.kafka.consumerProperties(consumerGroupId = topic.konsumentGruppe),
            StringDeserializer(),
            StringDeserializer(),
        )
        logger.info("Created kafka consumer job for ${topic.navn}")
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
                            logger.info("Fant $antallMeldinger nye meldinger for ${topic.navn}")
                            records.forEach { record ->
                                val oppdateringVirksomhet = Json.decodeFromString<OppdateringVirksomhet>(record.value())
                                when (oppdateringVirksomhet.endringstype) {
                                    BrregVirksomhetEndringstype.Ukjent,
                                    BrregVirksomhetEndringstype.Endring,
                                    BrregVirksomhetEndringstype.Ny,
                                    -> oppdateringVirksomhet.metadata?.let { brregVirksomhet ->
                                        try {
                                            val virksomhet = brregVirksomhet.tilVirksomhet(
                                                status = oppdateringVirksomhet.endringstype.tilStatus(),
                                                oppdateringsId = oppdateringVirksomhet.oppdateringsid,
                                            )
                                            repository.insertVirksomhet(virksomhet)
                                            repository.insertNæringsundergrupper(virksomhet)
                                        } catch (_: UgyldigAdresseException) {
                                            antallIrrelevanteBedrifter += 1
                                        }
                                    }

                                    BrregVirksomhetEndringstype.Sletting,
                                    BrregVirksomhetEndringstype.Fjernet,
                                    -> repository.oppdaterStatus(
                                        orgnr = oppdateringVirksomhet.orgnummer,
                                        status = oppdateringVirksomhet.endringstype.tilStatus(),
                                        oppdatertAvBrregOppdateringsId = oppdateringVirksomhet.oppdateringsid,
                                    )
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

    @Serializable
    data class OppdateringVirksomhet(
        val orgnummer: String,
        val oppdateringsid: Long,
        val endringstype: BrregVirksomhetEndringstype,
        val metadata: BrregVirksomhetDto? = null,
        val endringstidspunkt: Instant,
    )

    enum class BrregVirksomhetEndringstype {
        Ukjent, // Ukjent type endring. Ofte fordi endringen har skjedd før endringstype ble innført.
        Endring, // Enheten har blitt endret i Enhetsregisteret
        Ny, // Enheten har blitt lagt til i Enhetsregisteret
        Sletting, // Enheten har blitt slettet fra Enhetsregisteret
        Fjernet, // Enheten har blitt fjernet fra Åpne Data. Eventuelle kopier skal også fjerne enheten.
        ;

        fun tilStatus() =
            when (this) {
                Ukjent,
                Endring,
                Ny,
                -> VirksomhetStatus.AKTIV

                Sletting -> VirksomhetStatus.SLETTET
                Fjernet -> VirksomhetStatus.FJERNET
            }
    }
}
