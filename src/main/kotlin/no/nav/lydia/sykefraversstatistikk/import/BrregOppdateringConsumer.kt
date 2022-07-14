package no.nav.lydia.sykefraversstatistikk.import

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.datetime.Instant
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.integrasjoner.brreg.BrregVirksomhetDto
import no.nav.lydia.integrasjoner.brreg.tilVirksomhet
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import kotlin.coroutines.CoroutineContext

object BrregOppdateringConsumer : CoroutineScope {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    lateinit var job: Job
    lateinit var kafka: Kafka

    lateinit var repository: VirksomhetRepository

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(BrregOppdateringConsumer::cancel))
    }

    fun create(kafka: Kafka, repository: VirksomhetRepository) {
        logger.info("Creating kafka consumer job for brreg oppdatering")
        this.job = Job()
        this.kafka = kafka
        this.repository = repository
        logger.info("Created kafka consumer job for brreg oppdatering")
    }

    fun run() {
        launch {
            KafkaConsumer(
                kafka.consumerProperties(),
                StringDeserializer(),
                StringDeserializer()
            ).use { consumer ->
                consumer.subscribe(listOf(kafka.brregOppdateringTopic))
                logger.info("Kafka consumer subscribed to ${kafka.brregOppdateringTopic}")

                while (job.isActive) {
                    try {
                        val records = consumer.poll(Duration.ofSeconds(1))
                        val antallMeldinger = records.count()
                        if (antallMeldinger < 1) continue
                        logger.info("Fant $antallMeldinger nye meldinger")
                        records.forEach { record ->
                            val oppdateringVirksomhet = Json.decodeFromString<OppdateringVirksomhet>(record.value())
                            when (oppdateringVirksomhet.endringstype) {
                                Endringstype.Ukjent,
                                Endringstype.Endring,
                                Endringstype.Ny -> oppdateringVirksomhet.metadata?.let { brregVirksomhet ->
                                    val virksomhet = brregVirksomhet.tilVirksomhet(
                                        status = oppdateringVirksomhet.endringstype.tilStatus(),
                                        oppdateringsId = oppdateringVirksomhet.oppdateringsId
                                    )
                                    repository.insert(virksomhet)
                                }
                                Endringstype.Sletting,
                                Endringstype.Fjernet -> repository.oppdaterStatus(
                                    orgnr = oppdateringVirksomhet.orgnummer,
                                    status = oppdateringVirksomhet.endringstype.tilStatus(),
                                    oppdatertAvBrregOppdateringsId = oppdateringVirksomhet.oppdateringsId
                                )
                            }

                        }
                        logger.info("Lagret $antallMeldinger meldinger")

                        consumer.commitSync()
                    } catch (e: RetriableException) {
                        logger.warn("Had a retriable exception, retrying", e)
                    }
                    delay(kafka.consumerLoopDelay)
                }
            }
        }
    }

    fun cancel() {
        logger.info("Stopping kafka consumer job for brreg oppdatering")
        job.cancel()
        logger.info("Stopped kafka consumer job for brreg oppdatering")
    }

    @kotlinx.serialization.Serializable
    private data class OppdateringVirksomhet(
        val orgnummer: String,
        val oppdateringsId: Long,
        val endringstype: Endringstype,
        val metadata: BrregVirksomhetDto? = null,
        val endringstidspunkt: Instant
    )

    private enum class Endringstype {
        Ukjent, // Ukjent type endring. Ofte fordi endringen har skjedd før endringstype ble innført.
        Endring, // Enheten har blitt endret i Enhetsregisteret
        Ny, // Enheten har blitt lagt til i Enhetsregisteret
        Sletting, // Enheten har blitt slettet fra Enhetsregisteret
        Fjernet; // Enheten har blitt fjernet fra Åpne Data. Eventuelle kopier skal også fjerne enheten.

        fun tilStatus() = when(this) {
            Ukjent,
            Endring,
            Ny ->  VirksomhetStatus.AKTIV
            Sletting -> VirksomhetStatus.SLETTET
            Fjernet -> VirksomhetStatus.FJERNET
        }
    }
}
