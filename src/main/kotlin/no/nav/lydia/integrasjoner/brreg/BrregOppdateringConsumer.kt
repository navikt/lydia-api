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
import no.nav.lydia.virksomhet.VirksomhetService
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.errors.WakeupException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import kotlin.coroutines.CoroutineContext

object BrregOppdateringConsumer : CoroutineScope {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    private lateinit var job: Job
    private lateinit var kafka: Kafka

    private lateinit var virksomhetService: VirksomhetService
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>
    private val topicNavn = Topic.BRREG_OPPDATERING_TOPIC.navn
    private val konsumentGruppe = Topic.BRREG_OPPDATERING_TOPIC.konsumentGruppe

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(BrregOppdateringConsumer::cancel))
    }

    fun create(
        kafka: Kafka,
        virksomhetService: VirksomhetService,
    ) {
        logger.info("Creating kafka consumer job for $topicNavn")
        job = Job()
        BrregOppdateringConsumer.kafka = kafka
        BrregOppdateringConsumer.virksomhetService = virksomhetService
        kafkaConsumer = KafkaConsumer(
            BrregOppdateringConsumer.kafka.consumerProperties(consumerGroupId = konsumentGruppe),
            StringDeserializer(),
            StringDeserializer(),
        )
        logger.info("Created kafka consumer job for $topicNavn")
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
                            logger.info("Fant $antallMeldinger nye meldinger for $topicNavn")
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
                                            virksomhetService.insertVirksomhet(virksomhet)
                                            virksomhetService.insertNæringsundergrupper(virksomhet)
                                        } catch (e: UgyldigAdresseException) {
                                            antallIrrelevanteBedrifter += 1
                                        }
                                    }

                                    BrregVirksomhetEndringstype.Sletting,
                                    BrregVirksomhetEndringstype.Fjernet,
                                    -> virksomhetService.slettEllerFjernVirksomhet(oppdateringVirksomhet)
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
                    logger.info("BrregOppdateringConsumer is shutting down...")
                } catch (e: Exception) {
                    logger.error("Exception is shutting down kafka listner for $topicNavn", e)
                    throw e
                }
            }
        }
    }

    private fun cancel() =
        runBlocking {
            logger.info("Stopping kafka consumer job for $topicNavn")
            kafkaConsumer.wakeup()
            job.cancelAndJoin()
            logger.info("Stopped kafka consumer job for $topicNavn")
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
