package no.nav.lydia.helper

import com.google.gson.GsonBuilder
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.time.withTimeout
import kotlinx.coroutines.time.withTimeoutOrNull
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.OppdateringVirksomhet
import no.nav.lydia.sykefraversstatistikk.import.KeySykefraversstatistikkMetadataVirksomhet
import no.nav.lydia.sykefraversstatistikk.import.KeySykefraversstatistikkPerKategori
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkMetadataVirksomhetImportDto
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto
import org.apache.kafka.clients.CommonClientConfigs
import org.apache.kafka.clients.admin.AdminClient
import org.apache.kafka.clients.admin.AdminClientConfig.BOOTSTRAP_SERVERS_CONFIG
import org.apache.kafka.clients.admin.NewTopic
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.clients.producer.KafkaProducer
import org.apache.kafka.clients.producer.ProducerConfig
import org.apache.kafka.clients.producer.ProducerRecord
import org.apache.kafka.clients.producer.RecordMetadata
import org.apache.kafka.common.config.SaslConfigs
import org.apache.kafka.common.serialization.StringDeserializer
import org.apache.kafka.common.serialization.StringSerializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.KafkaContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.utility.DockerImageName
import java.time.Duration
import java.util.*
import no.nav.lydia.sykefraversstatistikk.import.GradertSykemeldingImportDto


class KafkaContainerHelper(
    network: Network = Network.newNetwork(),
    log: Logger = LoggerFactory.getLogger(KafkaContainerHelper::class.java),
) {
    companion object {
        const val statistikkMetadataVirksomhetTopic = "arbeidsgiver.sykefravarsstatistikk-metadata-virksomhet-v1"
        const val statistikkLandTopic = "arbeidsgiver.sykefravarsstatistikk-land-v1"
        const val statistikkSektorTopic = "arbeidsgiver.sykefravarsstatistikk-sektor-v1"
        const val statistikkBransjeTopic = "arbeidsgiver.sykefravarsstatistikk-bransje-v1"
        const val statistikkNæringTopic = "arbeidsgiver.sykefravarsstatistikk-naring-v1"
        const val statistikkNæringskodeTopic = "arbeidsgiver.sykefravarsstatistikk-naringskode-v1"
        const val statistikkVirksomhetTopic = "arbeidsgiver.sykefravarsstatistikk-virksomhet-v1"
        const val statistikkVirksomhetGraderingTopic = "arbeidsgiver.sykefravarsstatistikk-virksomhet-gradert-v1"
        const val iaSakTopic = "pia.ia-sak-v1"
        const val iaSakStatistikkTopic = "pia.ia-sak-statistikk-v1"
        const val iaSakStatusTopic = "pia.ia-sak-status-v1"
        const val iaSakLeveranseTopic = "pia.ia-sak-leveranse-v1"
        const val brregOppdateringTopic = "pia.brreg-oppdatering"
        const val brregAlleVirksomheterTopic = "pia.brreg-alle-virksomheter"
    }

    private val gson = GsonBuilder().create()
    private val kafkaNetworkAlias = "kafkaContainer"
    private var adminClient: AdminClient
    private var kafkaProducer: KafkaProducer<String, String>

    val kafkaContainer = KafkaContainer(
        DockerImageName.parse("confluentinc/cp-kafka:7.4.0")
    )
        .withKraft()
        .withNetwork(network)
        .withNetworkAliases(kafkaNetworkAlias)
        .withLogConsumer(Slf4jLogConsumer(log).withPrefix(kafkaNetworkAlias).withSeparateOutputStreams())
        .withEnv(
            mapOf(
                "KAFKA_LOG4J_LOGGERS" to "org.apache.kafka.image.loader.MetadataLoader=WARN",
                "KAFKA_AUTO_LEADER_REBALANCE_ENABLE" to "false",
                "KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS" to "1",
                "TZ" to TimeZone.getDefault().id
            )
        )
        .withCreateContainerCmdModifier { cmd -> cmd.withName("$kafkaNetworkAlias-${System.currentTimeMillis()}") }
        .waitingFor(HostPortWaitStrategy())
        .apply {
            start()
            adminClient = AdminClient.create(mapOf(BOOTSTRAP_SERVERS_CONFIG to this.bootstrapServers))
            createTopic(
                iaSakTopic,
                brregOppdateringTopic,
                brregAlleVirksomheterTopic,
                statistikkMetadataVirksomhetTopic,
                statistikkLandTopic,
                statistikkSektorTopic,
                statistikkBransjeTopic,
                statistikkVirksomhetTopic,
                statistikkVirksomhetGraderingTopic,
                iaSakStatusTopic,
            )
            kafkaProducer = producer()
        }

    fun nyKonsument(consumerGroupId: String) =
        Kafka(
            brokers = kafkaContainer.bootstrapServers,
            iaSakTopic = iaSakTopic,
            iaSakStatistikkTopic = iaSakStatistikkTopic,
            iaSakStatusTopic = iaSakStatusTopic,
            iaSakLeveranseTopic = iaSakLeveranseTopic,
            statistikkMetadataVirksomhetTopic = statistikkMetadataVirksomhetTopic,
            statistikkLandTopic = statistikkLandTopic,
            statistikkSektorTopic = statistikkSektorTopic,
            statistikkBransjeTopic = statistikkBransjeTopic,
            statistikkNæringTopic = statistikkNæringTopic,
            statistikkNæringskodeTopic = statistikkNæringskodeTopic,
            statistikkVirksomhetTopic = statistikkVirksomhetTopic,
            statistikkVirksomhetGraderingTopic = statistikkVirksomhetGraderingTopic,
            brregOppdateringTopic = brregOppdateringTopic,
            brregAlleVirksomheterTopic = brregAlleVirksomheterTopic,
            consumerLoopDelay = 1,
            credstorePassword = "",
            keystoreLocation = "",
            truststoreLocation = ""
        ).consumerProperties(consumerGroupId = consumerGroupId)
            .let { config ->
                KafkaConsumer(config, StringDeserializer(), StringDeserializer())
            }

    fun envVars() = mapOf(
        "KAFKA_BROKERS" to "BROKER://$kafkaNetworkAlias:9092,PLAINTEXT://$kafkaNetworkAlias:9092",
        "KAFKA_TRUSTSTORE_PATH" to "",
        "KAFKA_KEYSTORE_PATH" to "",
        "KAFKA_CREDSTORE_PASSWORD" to "",
        "STATISTIKK_LAND_TOPIC" to statistikkLandTopic,
        "STATISTIKK_METADATA_VIRKSOMHET_TOPIC" to statistikkMetadataVirksomhetTopic,
        "STATISTIKK_SEKTOR_TOPIC" to statistikkSektorTopic,
        "STATISTIKK_BRANSJE_TOPIC" to statistikkBransjeTopic,
        "STATISTIKK_NARING_TOPIC" to statistikkNæringTopic,
        "STATISTIKK_NARINGSKODE_TOPIC" to statistikkNæringskodeTopic,
        "STATISTIKK_VIRKSOMHET_TOPIC" to statistikkVirksomhetTopic,
        "STATISTIKK_VIRKSOMHET_GRADERING_TOPIC" to statistikkVirksomhetGraderingTopic,
        "IA_SAK_TOPIC" to iaSakTopic,
        "IA_SAK_STATISTIKK_TOPIC" to iaSakStatistikkTopic,
        "IA_SAK_STATUS_TOPIC" to iaSakStatusTopic,
        "IA_SAK_LEVERANSE_TOPIC" to iaSakLeveranseTopic,
        "BRREG_OPPDATERING_TOPIC" to brregOppdateringTopic,
        "BRREG_ALLE_VIRKSOMHETER_TOPIC" to brregAlleVirksomheterTopic
    )

    private fun createTopic(vararg topics: String) {
        val newTopics = topics
            .map { topic -> NewTopic(topic, 1, 1.toShort()) }
        adminClient.createTopics(newTopics)
    }


    private fun KafkaContainer.producer(): KafkaProducer<String, String> =
        KafkaProducer(
            mapOf(
                CommonClientConfigs.BOOTSTRAP_SERVERS_CONFIG to this.bootstrapServers,
                CommonClientConfigs.SECURITY_PROTOCOL_CONFIG to "PLAINTEXT",
                ProducerConfig.ACKS_CONFIG to "all",
                ProducerConfig.MAX_IN_FLIGHT_REQUESTS_PER_CONNECTION to "1",
                ProducerConfig.LINGER_MS_CONFIG to "0",
                ProducerConfig.RETRIES_CONFIG to "0",
                ProducerConfig.BATCH_SIZE_CONFIG to "1",
                SaslConfigs.SASL_MECHANISM to "PLAIN"
            ),
            StringSerializer(),
            StringSerializer()
        )

    fun sendOgVentTilKonsumert(nøkkel: String, melding: String, topic: String, konsumentGruppeId: String) {
        runBlocking {
            val sendtMelding = kafkaProducer.send(ProducerRecord(topic, nøkkel, melding)).get()
            ventTilKonsumert(
                konsumentGruppeId = konsumentGruppeId,
                recordMetadata = sendtMelding
            )
        }
    }

    fun sendStatistikkMetadataVirksomhetIBulkOgVentTilKonsumert(
        importDtoer: List<SykefraversstatistikkMetadataVirksomhetImportDto>,
    ) {
        runBlocking {
            val sendteMeldinger = importDtoer.map { melding ->
                kafkaProducer.send(melding.tilProducerRecord()).get()
            }
            ventTilKonsumert(
                konsumentGruppeId = Kafka.statistikkMetadataVirksomhetGroupId,
                recordMetadata = sendteMeldinger.last()
            )
        }
    }

    fun sendSykefraversstatistikkPerKategoriIBulkOgVentTilKonsumert(
        importDtoer: List<SykefraversstatistikkPerKategoriImportDto>,
        topic: String,
        groupId: String,
    ) {
        runBlocking {
            if (importDtoer.isEmpty()) return@runBlocking

            val sendteMeldinger = importDtoer.map { melding ->
                kafkaProducer.send(ProducerRecord(
                    topic,
                    gson.toJson(
                        KeySykefraversstatistikkPerKategori(
                            kategori = melding.kategori.name,
                            kode = melding.kode,
                            årstall = melding.sistePubliserteKvartal.årstall,
                            kvartal = melding.sistePubliserteKvartal.kvartal
                        ),
                    ),
                    gson.toJson(melding)
                )).get()
            }
            ventTilKonsumert(
                konsumentGruppeId = groupId,
                recordMetadata = sendteMeldinger.last()
            )
        }
    }

    fun sendStatistikkVirksomhetGraderingOgVentTilKonsumert(
            importDtoer: List<GradertSykemeldingImportDto>,
            topic: String,
            groupId: String,
    ) {
        runBlocking {
            if (importDtoer.isEmpty()) return@runBlocking

            val sendteMeldinger = importDtoer.map { melding ->
                kafkaProducer.send(ProducerRecord(
                    topic,
                    gson.toJson(
                        KeySykefraversstatistikkPerKategori(
                            kategori = melding.kategori,
                            kode = melding.kode,
                            årstall = melding.sistePubliserteKvartal.årstall,
                            kvartal = melding.sistePubliserteKvartal.kvartal
                        ),
                    ),
                    gson.toJson(melding)
                )).get()
            }
            ventTilKonsumert(
                konsumentGruppeId = groupId,
                recordMetadata = sendteMeldinger.last()
            )
        }
    }

    fun sendBrregOppdateringer(virksomheter: List<OppdateringVirksomhet>) = runBlocking {
        if (virksomheter.isEmpty()) return@runBlocking

        val sendteMeldinger = virksomheter.map {
            kafkaProducer.send(it.tilProducerRecord()).get()
        }

        ventTilKonsumert(
            konsumentGruppeId = Kafka.brregConsumerGroupId,
            recordMetadata = sendteMeldinger.last()
        )
    }

    fun sendBrregOppdatering(virksomhet: OppdateringVirksomhet) {
        runBlocking {
            val sendtMelding = kafkaProducer.send(virksomhet.tilProducerRecord()).get()
            ventTilKonsumert(
                konsumentGruppeId = Kafka.brregConsumerGroupId,
                recordMetadata = sendtMelding
            )
        }
    }

    private fun OppdateringVirksomhet.tilProducerRecord() = ProducerRecord(
            brregOppdateringTopic,
            this.orgnummer,
            Json.encodeToString(
                this
            )
        )

    private fun SykefraversstatistikkMetadataVirksomhetImportDto.tilProducerRecord() =
        ProducerRecord(
            statistikkMetadataVirksomhetTopic,
            gson.toJson(
                KeySykefraversstatistikkMetadataVirksomhet(
                    orgnr = orgnr,
                    arstall = årstall,
                    kvartal = kvartal
                ),
            ),
            gson.toJson(this)
        )

    private suspend fun ventTilKonsumert(
        konsumentGruppeId: String,
        recordMetadata: RecordMetadata
    ) =
        withTimeoutOrNull(Duration.ofSeconds(5)) {
            do {
                delay(timeMillis = 5L)
            } while (consumerSinOffset(
                    consumerGroup = konsumentGruppeId,
                    topic = recordMetadata.topic()
                ) <= recordMetadata.offset()
            )
        }

    suspend fun ventOgKonsumerKafkaMeldinger(
        key: String,
        konsument: KafkaConsumer<String, String>,
        block: (meldinger: List<String>) -> Unit,
    ) {
        withTimeout(Duration.ofSeconds(10)) {
            launch {
                while (this.isActive) {
                    val records = konsument.poll(Duration.ofMillis(100))
                    val meldinger = records
                        .filter { it.key() == key }
                        .map { it.value() }
                    if (meldinger.isNotEmpty()) {
                        block(meldinger)
                        break
                    }
                }
            }
        }
    }

    private fun consumerSinOffset(consumerGroup: String, topic: String): Long {
        val offsetMetadata = adminClient.listConsumerGroupOffsets(consumerGroup)
            .partitionsToOffsetAndMetadata().get()
        return offsetMetadata[offsetMetadata.keys.firstOrNull { it.topic().contains(topic) }]?.offset() ?: -1
    }

}
