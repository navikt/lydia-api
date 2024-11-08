package no.nav.lydia.helper

import com.google.gson.GsonBuilder
import ia.felles.integrasjoner.jobbsender.Jobb
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.time.withTimeout
import kotlinx.coroutines.time.withTimeoutOrNull
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Topic
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.OppdateringVirksomhet
import no.nav.lydia.sykefraværsstatistikk.import.GradertSykemeldingImportDto
import no.nav.lydia.sykefraværsstatistikk.import.KeySykefraværsstatistikkMetadataVirksomhet
import no.nav.lydia.sykefraværsstatistikk.import.KeySykefraværsstatistikkPerKategori
import no.nav.lydia.sykefraværsstatistikk.import.SykefraværsstatistikkMetadataVirksomhetImportDto
import no.nav.lydia.sykefraværsstatistikk.import.SykefraværsstatistikkPerKategoriImportDto
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
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.kafka.ConfluentKafkaContainer
import org.testcontainers.utility.DockerImageName
import java.time.Duration
import java.util.TimeZone

class KafkaContainerHelper(
    network: Network = Network.newNetwork(),
    log: Logger = LoggerFactory.getLogger(KafkaContainerHelper::class.java),
) {
    private val gson = GsonBuilder().create()
    private val kafkaNetworkAlias = "kafkaContainer"
    private var adminClient: AdminClient
    private var kafkaProducer: KafkaProducer<String, String>

    val kafkaContainer = ConfluentKafkaContainer(
        DockerImageName.parse("confluentinc/cp-kafka:7.4.3"),
    )
        .withNetwork(network)
        .withNetworkAliases(kafkaNetworkAlias)
        .withLogConsumer(Slf4jLogConsumer(log).withPrefix(kafkaNetworkAlias).withSeparateOutputStreams())
        .withEnv(
            mapOf(
                "KAFKA_LOG4J_LOGGERS" to "org.apache.kafka.image.loader.MetadataLoader=WARN",
                "KAFKA_AUTO_LEADER_REBALANCE_ENABLE" to "false",
                "KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS" to "1",
                "TZ" to TimeZone.getDefault().id,
            ),
        )
        .withCreateContainerCmdModifier { cmd -> cmd.withName("$kafkaNetworkAlias-${System.currentTimeMillis()}") }
        .waitingFor(HostPortWaitStrategy())
        .apply {
            start()
            adminClient = AdminClient.create(mapOf(BOOTSTRAP_SERVERS_CONFIG to this.bootstrapServers))
            createTopics()
            kafkaProducer = producer()
        }

    fun nyKonsument(consumerGroupId: String) =
        Kafka(
            brokers = kafkaContainer.bootstrapServers,
            consumerLoopDelay = 1,
            credstorePassword = "",
            keystoreLocation = "",
            truststoreLocation = "",
        ).consumerProperties(consumerGroupId = consumerGroupId)
            .let { config ->
                KafkaConsumer(config, StringDeserializer(), StringDeserializer())
            }

    fun envVars() =
        mapOf(
            "KAFKA_BROKERS" to "BROKER://$kafkaNetworkAlias:9093,PLAINTEXT://$kafkaNetworkAlias:9093",
            "KAFKA_TRUSTSTORE_PATH" to "",
            "KAFKA_KEYSTORE_PATH" to "",
            "KAFKA_CREDSTORE_PASSWORD" to "",
        )

    private fun createTopics() {
        val newTopics = Topic.entries
            .map { topic -> NewTopic(topic.navn, 1, 1.toShort()) }
        adminClient.createTopics(newTopics)
    }

    private fun ConfluentKafkaContainer.producer(): KafkaProducer<String, String> =
        KafkaProducer(
            mapOf(
                CommonClientConfigs.BOOTSTRAP_SERVERS_CONFIG to this.bootstrapServers,
                CommonClientConfigs.SECURITY_PROTOCOL_CONFIG to "PLAINTEXT",
                ProducerConfig.ACKS_CONFIG to "1",
                ProducerConfig.MAX_IN_FLIGHT_REQUESTS_PER_CONNECTION to "5",
                ProducerConfig.LINGER_MS_CONFIG to "0",
                ProducerConfig.RETRIES_CONFIG to "0",
                ProducerConfig.BATCH_SIZE_CONFIG to "0",
                SaslConfigs.SASL_MECHANISM to "PLAIN",
            ),
            StringSerializer(),
            StringSerializer(),
        )

    fun sendOgVentTilKonsumert(
        nøkkel: String,
        melding: String,
        topic: Topic,
    ) {
        runBlocking {
            val sendtMelding = kafkaProducer.send(ProducerRecord(topic.navn, nøkkel, melding)).get()
            ventTilKonsumert(
                konsumentGruppeId = topic.konsumentGruppe,
                recordMetadata = sendtMelding,
            )
        }
    }

    fun sendStatistikkMetadataVirksomhetIBulkOgVentTilKonsumert(importDtoer: List<SykefraværsstatistikkMetadataVirksomhetImportDto>) {
        runBlocking {
            val sendteMeldinger = importDtoer.map { melding ->
                kafkaProducer.send(melding.tilProducerRecord()).get()
            }
            ventTilKonsumert(
                konsumentGruppeId = Topic.STATISTIKK_METADATA_VIRKSOMHET_TOPIC.konsumentGruppe,
                recordMetadata = sendteMeldinger.last(),
            )
        }
    }

    fun sendSykefraværsstatistikkPerKategoriIBulkOgVentTilKonsumert(
        importDtoer: List<SykefraværsstatistikkPerKategoriImportDto>,
        topic: Topic,
    ) {
        runBlocking {
            if (importDtoer.isEmpty()) return@runBlocking

            val sendteMeldinger = importDtoer.map { melding ->
                kafkaProducer.send(
                    ProducerRecord(
                        topic.navn,
                        gson.toJson(
                            KeySykefraværsstatistikkPerKategori(
                                kategori = melding.kategori.name,
                                kode = melding.kode,
                                årstall = melding.sistePubliserteKvartal.årstall,
                                kvartal = melding.sistePubliserteKvartal.kvartal,
                            ),
                        ),
                        gson.toJson(melding),
                    ),
                ).get()
            }
            ventTilKonsumert(
                konsumentGruppeId = topic.konsumentGruppe,
                recordMetadata = sendteMeldinger.last(),
            )
        }
    }

    fun sendStatistikkVirksomhetGraderingOgVentTilKonsumert(
        importDtoer: List<GradertSykemeldingImportDto>,
        topic: Topic,
    ) {
        runBlocking {
            if (importDtoer.isEmpty()) return@runBlocking

            val sendteMeldinger = importDtoer.map { melding ->
                kafkaProducer.send(
                    ProducerRecord(
                        topic.navn,
                        gson.toJson(
                            KeySykefraværsstatistikkPerKategori(
                                kategori = melding.kategori,
                                kode = melding.kode,
                                årstall = melding.sistePubliserteKvartal.årstall,
                                kvartal = melding.sistePubliserteKvartal.kvartal,
                            ),
                        ),
                        gson.toJson(melding),
                    ),
                ).get()
            }
            ventTilKonsumert(
                konsumentGruppeId = topic.konsumentGruppe,
                recordMetadata = sendteMeldinger.last(),
            )
        }
    }

    fun sendBrregOppdateringer(virksomheter: List<OppdateringVirksomhet>) =
        runBlocking {
            if (virksomheter.isEmpty()) return@runBlocking

            val sendteMeldinger = virksomheter.map {
                kafkaProducer.send(it.tilProducerRecord()).get()
            }

            ventTilKonsumert(
                konsumentGruppeId = Topic.BRREG_OPPDATERING_TOPIC.konsumentGruppe,
                recordMetadata = sendteMeldinger.last(),
            )
        }

    fun sendBrregOppdatering(virksomhet: OppdateringVirksomhet) {
        runBlocking {
            val sendtMelding = kafkaProducer.send(virksomhet.tilProducerRecord()).get()
            ventTilKonsumert(
                konsumentGruppeId = Topic.BRREG_OPPDATERING_TOPIC.konsumentGruppe,
                recordMetadata = sendtMelding,
            )
        }
    }

    fun sendJobbMeldingUtenParam(jobb: Jobb) {
        sendOgVentTilKonsumert(
            nøkkel = jobb.name,
            melding =
            """
                {
                    "jobb": "${jobb.name}",
                    "tidspunkt": "2023-01-01T00:00:00.000Z",
                    "applikasjon": "lydia-api"
                }
                """.trimIndent(),
            topic = Topic.JOBBLYTTER_TOPIC,
        )
    }

    fun sendJobbMelding(jobb: Jobb, parameter: String = "") {
        sendOgVentTilKonsumert(
            nøkkel = jobb.name,
            melding =
                """
                {
                    "jobb": "${jobb.name}",
                    "tidspunkt": "2023-01-01T00:00:00.000Z",
                    "parameter": "$parameter"
                    "applikasjon": "lydia-api"
                }
                """.trimIndent(),
            topic = Topic.JOBBLYTTER_TOPIC,
        )
    }

    private fun OppdateringVirksomhet.tilProducerRecord() =
        ProducerRecord(
            Topic.BRREG_OPPDATERING_TOPIC.navn,
            this.orgnummer,
            Json.encodeToString(
                this,
            ),
        )

    private fun SykefraværsstatistikkMetadataVirksomhetImportDto.tilProducerRecord() =
        ProducerRecord(
            Topic.STATISTIKK_METADATA_VIRKSOMHET_TOPIC.navn,
            gson.toJson(
                KeySykefraværsstatistikkMetadataVirksomhet(
                    orgnr = orgnr,
                    arstall = årstall,
                    kvartal = kvartal,
                ),
            ),
            gson.toJson(this),
        )

    private suspend fun ventTilKonsumert(
        konsumentGruppeId: String,
        recordMetadata: RecordMetadata,
    ) = withTimeoutOrNull(Duration.ofSeconds(5)) {
        do {
            delay(timeMillis = 1L)
        } while (consumerSinOffset(
                consumerGroup = konsumentGruppeId,
                topic = recordMetadata.topic(),
            ) <= recordMetadata.offset()
        )
    }

    suspend fun ventOgKonsumerKafkaMeldinger(
        key: String,
        konsument: KafkaConsumer<String, String>,
        block: (meldinger: List<String>) -> Unit,
    ) {
        withTimeout(Duration.ofSeconds(5)) {
            launch {
                while (this.isActive) {
                    val records = konsument.poll(Duration.ofMillis(50))
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

    suspend fun ventOgKonsumerKafkaMeldinger(
        keys: List<String>,
        konsument: KafkaConsumer<String, String>,
        block: (meldinger: List<String>) -> Unit,
    ) {
        withTimeout(Duration.ofSeconds(5)) {
            launch {
                while (this.isActive) {
                    val records = konsument.poll(Duration.ofMillis(50))
                    val meldinger = records
                        .filter { keys.contains(it.key()) }
                        .map { it.value() }
                    if (meldinger.isNotEmpty()) {
                        block(meldinger)
                        break
                    }
                }
            }
        }
    }

    private fun consumerSinOffset(
        consumerGroup: String,
        topic: String,
    ): Long {
        val offsetMetadata = adminClient.listConsumerGroupOffsets(consumerGroup)
            .partitionsToOffsetAndMetadata().get()
        return offsetMetadata[offsetMetadata.keys.firstOrNull { it.topic().contains(topic) }]?.offset() ?: -1
    }
}
