package no.nav.lydia.integrasjoner.kartlegging

import com.google.gson.GsonBuilder
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
import no.nav.lydia.appstatus.Helse
import no.nav.lydia.appstatus.Helsesjekk
import no.nav.lydia.ia.sak.SpørreundersøkelseService
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvarDto
import org.apache.kafka.clients.consumer.ConsumerRecord
import org.apache.kafka.clients.consumer.ConsumerRecords
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.errors.WakeupException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import java.util.UUID
import kotlin.coroutines.CoroutineContext

class KartleggingSvarConsumer :
    CoroutineScope,
    Helsesjekk {
    private lateinit var job: Job
    private lateinit var kafka: Kafka
    private lateinit var spørreundersøkelseService: SpørreundersøkelseService
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>
    private val topic = Topic.SPORREUNDERSOKELSE_SVAR_TOPIC

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(this::cancel))
    }

    fun create(
        kafka: Kafka,
        spørreundersøkelseService: SpørreundersøkelseService,
    ) {
        logger.info("Creating kafka consumer job for topic '${topic.navn}' i groupId '${topic.konsumentGruppe}'")
        this.job = Job()
        this.spørreundersøkelseService = spørreundersøkelseService
        this.kafka = kafka
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
                                spørreundersøkelseService.lagreSvar(
                                    records.tilSpørreundersøkelseSvarDto(),
                                )
                                logger.info("Lagret ${records.count()} meldinger i $consumer (topic '${topic.navn}') ")
                                consumer.commitSync()
                            }
                        } catch (e: RetriableException) {
                            logger.warn("Had a retriable exception in $consumer (topic '${topic.navn}'), retrying", e)
                        }
                        delay(kafka.consumerLoopDelay)
                    }
                } catch (e: WakeupException) {
                    logger.info("$consumer (topic '${topic.navn}')  is shutting down...")
                } catch (e: Exception) {
                    logger.error("Exception is shutting down kafka listner i $consumer (topic '${topic.navn}')", e)
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

    private fun ConsumerRecords<String, String>.tilSpørreundersøkelseSvarDto(): List<SpørreundersøkelseSvarDto> {
        val gson = GsonBuilder().create()
        return this.filter { erSpørreundersøkelseSvarMeldingenGyldig(it) }.map {
            gson.fromJson(
                it.value(),
                SpørreundersøkelseSvarDto::class.java,
            )
        }
    }

    private fun isRunning() = job.isActive

    override fun helse() = if (isRunning()) Helse.UP else Helse.DOWN

    companion object {
        private val logger: Logger = LoggerFactory.getLogger(this::class.java)

        fun String.erGyldigNøkkel() =
            try {
                val sesjonIdOgSpørsmålId = this.split("_")
                UUID.fromString(sesjonIdOgSpørsmålId[0])
                UUID.fromString(sesjonIdOgSpørsmålId[1])
                true
            } catch (e: Exception) {
                false
            }

        fun erSpørreundersøkelseSvarMeldingenGyldig(kartleggingSvarRecord: ConsumerRecord<String, String>): Boolean {
            val nøkkel = kartleggingSvarRecord.key()
            val verdi = kartleggingSvarRecord.value()

            try {
                Json.decodeFromString<SpørreundersøkelseSvarDto>(verdi)
            } catch (e: Exception) {
                logger.warn("Feil formatert Kafka melding (value) i topic ${kartleggingSvarRecord.topic()} for value '$verdi' ")
                return false
            }

            return if (nøkkel.erGyldigNøkkel()) {
                true
            } else {
                logger.warn("Feil formatert Kafka melding i topic ${kartleggingSvarRecord.topic()} for key $nøkkel")
                false
            }
        }
    }
}
