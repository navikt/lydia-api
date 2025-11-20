package no.nav.lydia.integrasjoner.jobblytter

import ia.felles.integrasjoner.jobbsender.Jobb
import ia.felles.integrasjoner.jobbsender.Jobb.engangsJobb
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakSamarbeidBigQueryEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakSamarbeidEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakSamarbeidEksportEttSamarbeid
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakSamarbeidsplanBigqueryEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakSamarbeidsplanEksport
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakStatistikkEksport
import ia.felles.integrasjoner.jobbsender.Jobb.materializedViewOppdatering
import ia.felles.integrasjoner.jobbsender.Jobb.næringsImport
import ia.felles.integrasjoner.jobbsender.Jobb.ryddeIUrørteSaker
import ia.felles.integrasjoner.jobbsender.Jobb.ryddeIUrørteSakerTørrKjør
import ia.felles.integrasjoner.jobbsender.Jobb.spørreundersøkelseBigQueryEksport
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
import no.nav.lydia.ia.eksport.IASakStatistikkEksporterer
import no.nav.lydia.ia.eksport.SamarbeidBigqueryEksporterer
import no.nav.lydia.ia.eksport.SamarbeidKafkaEksporterer
import no.nav.lydia.ia.eksport.SamarbeidsplanBigqueryEksporterer
import no.nav.lydia.ia.eksport.SamarbeidsplanKafkaEksporterer
import no.nav.lydia.ia.eksport.SpørreundersøkelseBigqueryEksporterer
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.vedlikehold.IASakSamarbeidOppdaterer
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer
import no.nav.lydia.vedlikehold.IaSakhendelseStatusJobb
import no.nav.lydia.vedlikehold.StatistikkViewOppdaterer
import no.nav.lydia.virksomhet.VirksomhetService
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.common.errors.RetriableException
import org.apache.kafka.common.errors.WakeupException
import org.apache.kafka.common.serialization.StringDeserializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.Duration
import kotlin.coroutines.CoroutineContext
import kotlin.coroutines.cancellation.CancellationException

object Jobblytter : CoroutineScope {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    private lateinit var job: Job
    private lateinit var kafka: Kafka

    private lateinit var kafkaConsumer: KafkaConsumer<String, String>
    private lateinit var iaSakStatusOppdaterer: IASakStatusOppdaterer
    private lateinit var iaSakEksporterer: IASakEksporterer
    private lateinit var iaSakStatistikkEksporterer: IASakStatistikkEksporterer
    private lateinit var næringsDownloader: NæringsDownloader
    private lateinit var statistikkViewOppdaterer: StatistikkViewOppdaterer
    private lateinit var iaSakhendelseStatusJobb: IaSakhendelseStatusJobb
    private lateinit var samarbeidsplanKafkaEksporterer: SamarbeidsplanKafkaEksporterer
    private lateinit var samarbeidBigqueryEksporterer: SamarbeidBigqueryEksporterer
    private lateinit var samarbeidsplanBigqueryEksporterer: SamarbeidsplanBigqueryEksporterer
    private lateinit var spørreundersøkelseBigqueryEksporterer: SpørreundersøkelseBigqueryEksporterer
    private lateinit var samarbeidKafkaEksporterer: SamarbeidKafkaEksporterer
    private lateinit var iaSakSamarbeidOppdaterer: IASakSamarbeidOppdaterer
    private lateinit var virksomhetService: VirksomhetService
    private lateinit var iaSakService: IASakService
    private val topic = Topic.JOBBLYTTER_TOPIC

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
        næringsDownloader: NæringsDownloader,
        statistikkViewOppdaterer: StatistikkViewOppdaterer,
        iaSakhendelseStatusJobb: IaSakhendelseStatusJobb,
        samarbeidsplanKafkaEksporterer: SamarbeidsplanKafkaEksporterer,
        samarbeidBigqueryEksporterer: SamarbeidBigqueryEksporterer,
        samarbeidsplanBigqueryEksporterer: SamarbeidsplanBigqueryEksporterer,
        spørreundersøkelseBigqueryEksporterer: SpørreundersøkelseBigqueryEksporterer,
        samarbeidKafkaEksporterer: SamarbeidKafkaEksporterer,
        iaSakSamarbeidOppdaterer: IASakSamarbeidOppdaterer,
        virksomhetService: VirksomhetService,
        iaSakService: IASakService,
    ) {
        logger.info("Creating kafka consumer job for ${topic.navn}")
        job = Job()
        Jobblytter.kafka = kafka

        kafkaConsumer = KafkaConsumer(
            Jobblytter.kafka.consumerProperties(consumerGroupId = topic.konsumentGruppe),
            StringDeserializer(),
            StringDeserializer(),
        )
        this.iaSakStatusOppdaterer = iaSakStatusOppdaterer
        this.iaSakEksporterer = iaSakEksporterer
        this.iaSakStatistikkEksporterer = iaSakStatistikkEksporterer
        this.næringsDownloader = næringsDownloader
        this.statistikkViewOppdaterer = statistikkViewOppdaterer
        this.iaSakhendelseStatusJobb = iaSakhendelseStatusJobb
        this.samarbeidsplanKafkaEksporterer = samarbeidsplanKafkaEksporterer
        this.samarbeidBigqueryEksporterer = samarbeidBigqueryEksporterer
        this.samarbeidsplanBigqueryEksporterer = samarbeidsplanBigqueryEksporterer
        this.spørreundersøkelseBigqueryEksporterer = spørreundersøkelseBigqueryEksporterer
        this.samarbeidKafkaEksporterer = samarbeidKafkaEksporterer
        this.iaSakSamarbeidOppdaterer = iaSakSamarbeidOppdaterer
        this.virksomhetService = virksomhetService
        this.iaSakService = iaSakService

        logger.info("Created kafka consumer job for ${topic.navn}")
    }

    fun run() {
        launch {
            kafkaConsumer.use { consumer ->
                try {
                    consumer.subscribe(listOf(topic.navn))
                    logger.info("Kafka consumer subscribed to ${topic.navn}")
                    while (job.isActive) {
                        val records = consumer.poll(Duration.ofSeconds(1))
                        records.forEach {
                            val jobInfo = Json.decodeFromString<SerializableJobbInfo>(it.value())
                            if (jobInfo.jobb.name != it.key()) {
                                logger.warn(
                                    "Received record with key ${it.key()} and value ${it.value()} from topic ${it.topic()} but jobInfo.job is ${jobInfo.jobb}",
                                )
                            } else {
                                logger.info("Starter jobb $jobInfo")
                                when (jobInfo.jobb) {
                                    engangsJobb -> {
                                        if (jobInfo.parameter.isNullOrEmpty()) {
                                            logger.warn("Forsøkte å starte jobb 'engangsJobb' med null/empty parameter. Avslutter")
                                        } else {
                                            val tørrKjør = jobInfo.parameter != "GO!"
                                            virksomhetService.finnSlettedeVirksomheterMedAktivSak().forEach { virksomhet ->
                                                logger.info("Virksomhet $virksomhet")
                                                if (!tørrKjør) {
                                                    iaSakService.avsluttSakForSlettetVirksomhet(virksomhet)
                                                }
                                            }
                                        }
                                    }

                                    ryddeIUrørteSaker -> {
                                        iaSakStatusOppdaterer.ryddeIUrørteSaker()
                                    }

                                    ryddeIUrørteSakerTørrKjør -> {
                                        iaSakStatusOppdaterer.ryddeIUrørteSaker(tørrKjør = true)
                                    }

                                    iaSakEksport -> {
                                        iaSakEksporterer.eksporter()
                                    }

                                    iaSakStatistikkEksport -> {
                                        iaSakStatistikkEksporterer.eksporter()
                                    }

                                    næringsImport -> {
                                        næringsDownloader.lastNedNæringer()
                                    }

                                    materializedViewOppdatering -> {
                                        statistikkViewOppdaterer.oppdaterStatistikkView()
                                    }

                                    iaSakSamarbeidsplanEksport -> {
                                        samarbeidsplanKafkaEksporterer.eksporter()
                                    }

                                    iaSakSamarbeidEksport -> {
                                        samarbeidKafkaEksporterer.eksporterAlleSamarbeid()
                                    }

                                    iaSakSamarbeidEksportEttSamarbeid -> {
                                        if (jobInfo.parameter.isNullOrEmpty()) {
                                            logger.warn(
                                                "Forsøkte å starte jobb 'iaSakSamarbeidEksportEttSamarbeid' med null/empty parameter. " +
                                                    "Forventer et samarbeidId. Avslutter",
                                            )
                                        } else {
                                            val samarbeidId = jobInfo.parameter
                                            samarbeidKafkaEksporterer.eksporterEnkeltSamarbeid(samarbeidIdAsString = samarbeidId)
                                        }
                                    }

                                    iaSakSamarbeidBigQueryEksport -> {
                                        samarbeidBigqueryEksporterer.eksporter()
                                    }

                                    iaSakSamarbeidsplanBigqueryEksport -> {
                                        samarbeidsplanBigqueryEksporterer.eksporter()
                                    }

                                    spørreundersøkelseBigQueryEksport -> {
                                        spørreundersøkelseBigqueryEksporterer.eksporter()
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
                } catch (e: RetriableException) {
                    logger.error("Kafka consumer got retriable exception", e)
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

    @Serializable
    data class SerializableJobbInfo(
        override val jobb: Jobb,
        override val tidspunkt: String,
        override val parameter: String? = "",
        override val applikasjon: String,
    ) : JobbInfo

    private fun cancel() =
        runBlocking {
            logger.info("Stopping kafka consumer job for topic '${topic.navn}'")
            kafkaConsumer.wakeup()
            job.cancelAndJoin()
            logger.info("Stopped kafka consumer job for topic '${topic.navn}'")
        }
}
