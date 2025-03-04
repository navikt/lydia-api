package no.nav.lydia.integrasjoner.salesforce.aktiviteter

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
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.errors.WakeupException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import kotlin.coroutines.CoroutineContext

class SalesforceAktivitetKonsument :
    CoroutineScope,
    Helsesjekk {
    private lateinit var job: Job
    private lateinit var kafka: Kafka
    private lateinit var kafkaConsumer: KafkaConsumer<String, String>
    private lateinit var salesforceAktivitetService: SalesforceAktivitetService
    private val topic = Topic.SALESFORCE_AKTIVITET_TOPIC
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
        salesforceAktivitetService: SalesforceAktivitetService,
    ) {
        logger.info("Creating kafka consumer job for topic '${topic.navn}' i groupId '${topic.konsumentGruppe}'")
        this.job = Job()
        this.kafka = kafka
        this.salesforceAktivitetService = salesforceAktivitetService
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
                                    val aktiviteter = records.map {
                                        json.decodeFromString<SalesforceAktivitetDto>(it.value())
                                        // TODO: Håndter feilformaterte meldinger
                                    }.filter { aktivitet ->
                                        !aktivitet.IACaseNumber__c.isNullOrBlank()
                                    }

                                    aktiviteter.forEach {
                                        salesforceAktivitetService.lagreAktivitet(it.tilDomene())
                                    }
                                    logger.info("Behandlet ${records.count()} meldinger i topic '${topic.navn}'). ${aktiviteter.size} er knyttet til et saksnr")
//                                consumer.commitSync()
                                } catch (e: Exception) {
                                    logger.warn("Fikk feilmelding ved lagring av aktivitet; ${e.message}")
                                }
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

    private fun isRunning() = job.isActive

    override fun helse() = if (isRunning()) Helse.UP else Helse.DOWN

    companion object {
        private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    }
}
