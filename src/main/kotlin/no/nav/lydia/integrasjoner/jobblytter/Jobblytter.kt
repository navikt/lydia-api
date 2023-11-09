package no.nav.lydia.integrasjoner.jobblytter

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.ia.eksport.IASakEksporterer
import no.nav.lydia.ia.eksport.IASakLeveranseEksportør
import no.nav.lydia.ia.eksport.IASakStatistikkEksporterer
import no.nav.lydia.ia.eksport.IASakStatusEksportør
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.errors.WakeupException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import kotlin.coroutines.CoroutineContext

object Jobblytter : CoroutineScope {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    lateinit var job: Job
    lateinit var kafka: Kafka

    private lateinit var kafkaConsumer: KafkaConsumer<String, String>
    lateinit var iaSakEksporterer: IASakEksporterer
    lateinit var iaSakStatistikkEksporterer: IASakStatistikkEksporterer
    lateinit var iaSakLeveranseEksportør: IASakLeveranseEksportør
    lateinit var iaSakStatusExportør: IASakStatusEksportør
    lateinit var næringsDownloader: NæringsDownloader

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(Jobblytter::cancel))
    }

    fun create(
        kafka: Kafka,
        iaSakEksporterer: IASakEksporterer,
        iaSakStatistikkEksporterer: IASakStatistikkEksporterer,
        iaSakLeveranseEksportør: IASakLeveranseEksportør,
        iaSakStatusExportør: IASakStatusEksportør,
        næringsDownloader: NæringsDownloader
    ) {
        logger.info("Creating kafka consumer job for ${kafka.jobblytterTopic}")
        job = Job()
        Jobblytter.kafka = kafka
        kafkaConsumer = KafkaConsumer(
            Jobblytter.kafka.consumerProperties(consumerGroupId = Kafka.jobblytterConsumerGroupId),
            StringDeserializer(),
            StringDeserializer()
        )
        this.iaSakEksporterer = iaSakEksporterer
        this.iaSakStatusExportør = iaSakStatusExportør
        this.iaSakStatistikkEksporterer = iaSakStatistikkEksporterer
        this.iaSakLeveranseEksportør = iaSakLeveranseEksportør
        this.næringsDownloader = næringsDownloader

        logger.info("Created kafka consumer job for ${kafka.jobblytterTopic}")
    }

    fun run() {
        launch {
            kafkaConsumer.use { consumer ->
                try {
                    consumer.subscribe(listOf(kafka.jobblytterTopic))
                    logger.info("Kafka consumer subscribed to ${kafka.jobblytterTopic}")
                    while (job.isActive) {
                        val records = consumer.poll(Duration.ofSeconds(1))
                        records.forEach {
                            val jobInfo = Json.decodeFromString<JobInfo>(it.value())
                            if (jobInfo.jobb.name != it.key())
                                logger.warn("Received record with key ${it.key()} and value ${it.value()} from topic ${it.topic()} but jobInfo.job is ${jobInfo.jobb}")
                            else {
                                logger.info("Starter jobb $jobInfo")
                                when (jobInfo.jobb) {
                                    Jobb.iaSakEksport -> {
                                        iaSakEksporterer.eksporter()
                                    }
                                    Jobb.iaSakStatistikkEksport -> {
                                        iaSakStatistikkEksporterer.eksporter()
                                    }
                                    Jobb.iaSakStatusExport -> {
                                        iaSakStatusExportør.eksporter()
                                    }
                                    Jobb.iaSakLeveranseEksport -> {
                                        iaSakLeveranseEksportør.eksporter()
                                    }
                                    Jobb.næringsImport -> {
                                        næringsDownloader.lastNedNæringer()
                                    }
                                }
                                logger.info("Jobb ${jobInfo.jobb} ferdig")
                            }
                        }
                        consumer.commitSync()
                    }
                } catch (e: WakeupException) {
                    logger.info("Jobblytter is shutting down")
                } catch (e: RetriableException) {
                    logger.error("Kafka consumer got retriable exception", e)
                } catch (e: Exception) {
                    logger.error("Exception is shutting down kafka listner for ${kafka.jobblytterTopic}", e)
                    throw e
                }
            }
        }
    }

    fun cancel() = runBlocking {
        logger.info("Cancelling kafka consumer job for ${kafka.jobblytterTopic}")
        kafkaConsumer.wakeup()
        job.cancelAndJoin()
        logger.info("Cancelled kafka consumer job for ${kafka.jobblytterTopic}")
    }
}

@Serializable
data class JobInfo(
    val jobb: Jobb,
    val tidspunkt: String,
    val applikasjon: String,
)

enum class Jobb {
    iaSakEksport,
    iaSakStatistikkEksport,
    iaSakStatusExport,
    iaSakLeveranseEksport,
    næringsImport;
}