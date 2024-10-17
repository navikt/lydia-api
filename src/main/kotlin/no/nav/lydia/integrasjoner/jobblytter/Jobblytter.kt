package no.nav.lydia.integrasjoner.jobblytter

import ia.felles.integrasjoner.jobbsender.Jobb
import ia.felles.integrasjoner.jobbsender.Jobb.*
import ia.felles.integrasjoner.jobbsender.JobbInfo
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Topic
import no.nav.lydia.ia.eksport.IASakEksporterer
import no.nav.lydia.ia.eksport.IASakLeveranseEksportør
import no.nav.lydia.ia.eksport.IASakStatistikkEksporterer
import no.nav.lydia.ia.eksport.IASakStatusEksportør
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer
import no.nav.lydia.vedlikehold.IaSakhendelseStatusJobb
import no.nav.lydia.vedlikehold.StatistikkViewOppdaterer
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
    private lateinit var job: Job
    private lateinit var kafka: Kafka

    private lateinit var kafkaConsumer: KafkaConsumer<String, String>
    private lateinit var iaSakStatusOppdaterer: IASakStatusOppdaterer
    private lateinit var iaSakEksporterer: IASakEksporterer
    private lateinit var iaSakStatistikkEksporterer: IASakStatistikkEksporterer
    private lateinit var iaSakLeveranseEksportør: IASakLeveranseEksportør
    private lateinit var iaSakStatusExportør: IASakStatusEksportør
    private lateinit var næringsDownloader: NæringsDownloader
    private lateinit var statistikkViewOppdaterer: StatistikkViewOppdaterer
    private lateinit var iaSakhendelseStatusJobb: IaSakhendelseStatusJobb
    private val topicNavn = Topic.JOBBLYTTER_TOPIC.navn
    private val konsumentGruppe = Topic.JOBBLYTTER_TOPIC.konsumentGruppe

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(Jobblytter::cancel))
    }

    fun create(
        kafka: Kafka,
        iaSakStatusOppdaterer: IASakStatusOppdaterer,
        iaSakEksporterer: IASakEksporterer,
        iaSakStatistikkEksporterer: IASakStatistikkEksporterer,
        iaSakLeveranseEksportør: IASakLeveranseEksportør,
        iaSakStatusExportør: IASakStatusEksportør,
        næringsDownloader: NæringsDownloader,
        statistikkViewOppdaterer: StatistikkViewOppdaterer,
        iaSakhendelseStatusJobb: IaSakhendelseStatusJobb,
    ) {
        logger.info("Creating kafka consumer job for $topicNavn")
        job = Job()
        Jobblytter.kafka = kafka

        kafkaConsumer = KafkaConsumer(
            Jobblytter.kafka.consumerProperties(consumerGroupId = konsumentGruppe),
            StringDeserializer(),
            StringDeserializer()
        )
        this.iaSakStatusOppdaterer = iaSakStatusOppdaterer
        this.iaSakEksporterer = iaSakEksporterer
        this.iaSakStatusExportør = iaSakStatusExportør
        this.iaSakStatistikkEksporterer = iaSakStatistikkEksporterer
        this.iaSakLeveranseEksportør = iaSakLeveranseEksportør
        this.næringsDownloader = næringsDownloader
        this.statistikkViewOppdaterer = statistikkViewOppdaterer
        this.iaSakhendelseStatusJobb = iaSakhendelseStatusJobb

        logger.info("Created kafka consumer job for $topicNavn")
    }

    fun run() {
        launch {
            kafkaConsumer.use { consumer ->
                try {
                    consumer.subscribe(listOf(topicNavn))
                    logger.info("Kafka consumer subscribed to $topicNavn")
                    while (job.isActive) {
                        val records = consumer.poll(Duration.ofSeconds(1))
                        records.forEach {
                            val jobInfo = Json.decodeFromString<SerializableJobbInfo>(it.value())
                            if (jobInfo.jobb.name != it.key())
                                logger.warn("Received record with key ${it.key()} and value ${it.value()} from topic ${it.topic()} but jobInfo.job is ${jobInfo.jobb}")
                            else {
                                logger.info("Starter jobb $jobInfo")
                                when (jobInfo.jobb) {
                                    ryddeIUrørteSaker -> {
                                        iaSakStatusOppdaterer.ryddeIUrørteSaker()
                                    }

                                    ryddeIUrørteSakerTørrKjør -> {
                                        iaSakhendelseStatusJobb.kjør() // TODO: RYDD OPP
//                                        iaSakStatusOppdaterer.ryddeIUrørteSaker(tørrKjør = true)
                                    }

                                    iaSakEksport -> {
                                        iaSakEksporterer.eksporter()
                                    }

                                    iaSakStatistikkEksport -> {
                                        iaSakStatistikkEksporterer.eksporter()
                                    }

                                    iaSakStatusExport -> {
                                        iaSakStatusExportør.eksporter()
                                    }

                                    iaSakLeveranseEksport -> {
                                        iaSakLeveranseEksportør.eksporter()
                                    }

                                    næringsImport -> {
                                        næringsDownloader.lastNedNæringer()
                                    }

                                    materializedViewOppdatering -> {
                                        statistikkViewOppdaterer.oppdaterStatistikkView()
                                    }

                                    else -> {
                                        logger.info("Jobb '${jobInfo.jobb}' ignorert")
                                    }
                                }
                                logger.info("Jobb '${jobInfo.jobb}' ferdig")
                            }
                        }
                        consumer.commitSync()
                    }
                } catch (e: WakeupException) {
                    logger.info("Jobblytter is shutting down")
                } catch (e: RetriableException) {
                    logger.error("Kafka consumer got retriable exception", e)
                } catch (e: Exception) {
                    logger.error("Exception is shutting down kafka listner for $topicNavn", e)
                    throw e
                }
            }
        }
    }

    @Serializable
    data class SerializableJobbInfo(
        override val jobb: Jobb,
        override val tidspunkt: String,
        override val applikasjon: String,
    ) : JobbInfo

    private fun cancel() = runBlocking {
        logger.info("Cancelling kafka consumer job for $topicNavn")
        kafkaConsumer.wakeup()
        job.cancelAndJoin()
        logger.info("Cancelled kafka consumer job for $topicNavn")
    }
}
