package no.nav.lydia.integrasjoner.kartlegging

import com.google.gson.GsonBuilder
import kotlinx.coroutines.*
import no.nav.lydia.Kafka
import no.nav.lydia.appstatus.Helse
import no.nav.lydia.appstatus.Helsesjekk
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
import kotlinx.serialization.json.Json

class KartleggingSvarConsumer(
    val topic: String,
    val groupId: String
) : CoroutineScope, Helsesjekk  {


    private lateinit var job: Job
    private lateinit var kafka: Kafka
    private lateinit var kartleggingService: KartleggingService
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>
    private val consumer = "KartleggingSvarConsumer"

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(this::cancel))
    }

    fun create(kafka: Kafka, kartleggingService: KartleggingService) {
        logger.info("Creating kafka consumer job for topic '$topic' i groupId '$groupId'")
        this.job = Job()
        this.kartleggingService = kartleggingService
        this.kafka = kafka
        this.kafkaConsumer = KafkaConsumer(
            this.kafka.consumerProperties(consumerGroupId = groupId),
            StringDeserializer(),
            StringDeserializer()
        )
        logger.info("Created kafka consumer job for topic '$topic' i groupId '$groupId'")
    }

    fun run() {
        launch {
            kafkaConsumer.use { consumer ->
                try {
                    consumer.subscribe(listOf(topic))
                    logger.info("Kafka consumer subscribed to topic '$topic' of groupId '$groupId' )' in $consumer")

                    while (job.isActive) {
                        try {
                            val records = consumer.poll(Duration.ofSeconds(1))
                            if (!records.isEmpty) {
                                kartleggingService.lagreSvar(
                                    records.toKarleggingSvarDto()
                                )
                                logger.info("Lagret ${records.count()} meldinger i $consumer (topic '$topic') ")
                                consumer.commitSync()
                            }
                        } catch (e: RetriableException) {
                            logger.warn("Had a retriable exception in $consumer (topic '$topic'), retrying", e)
                        }
                        delay(kafka.consumerLoopDelay)
                    }
                } catch (e: WakeupException) {
                    logger.info("$consumer (topic '$topic')  is shutting down...")
                } catch (e: Exception) {
                    logger.error("Exception is shutting down kafka listner i $consumer (topic '$topic')", e)
                    throw e
                }
            }
        }
    }

    private fun cancel() = runBlocking {
        logger.info("Stopping kafka consumer job i $consumer (topic '$topic')")
        kafkaConsumer.wakeup()
        job.cancelAndJoin()
        logger.info("Stopped kafka consumer job i $consumer (topic '$topic')")
    }

    private fun ConsumerRecords<String, String>.toKarleggingSvarDto(): List<KartleggingSvarDto> {
        val gson = GsonBuilder().create()
        return this.filter { erKartleggingSvarMeldingenGyldig(it) }.map {
            gson.fromJson(
                it.value(),
                KartleggingSvarDto::class.java
            )
        }
    }


    private fun isRunning() = job.isActive

    override fun helse() = if (isRunning()) Helse.UP else Helse.DOWN

    companion object {

        private val logger: Logger = LoggerFactory.getLogger(this::class.java)
        fun String.erGyldigNøkkel() = try {
            val sesjonIdOgSpørsmålId = this.split("_")
            UUID.fromString(sesjonIdOgSpørsmålId[0])
            UUID.fromString(sesjonIdOgSpørsmålId[1])
            true
        } catch (e: Exception) {
            false
        }

        fun erKartleggingSvarMeldingenGyldig(kartleggingSvarRecord: ConsumerRecord<String, String>): Boolean {
            val nøkkel = kartleggingSvarRecord.key()
            val verdi = kartleggingSvarRecord.value()

            try {
                Json.decodeFromString<KartleggingSvarDto>(verdi)
            } catch (e: Exception){
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


