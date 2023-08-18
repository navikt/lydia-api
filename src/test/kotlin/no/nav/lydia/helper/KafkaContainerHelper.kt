package no.nav.lydia.helper

import com.google.gson.GsonBuilder
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.time.withTimeout
import kotlinx.coroutines.time.withTimeoutOrNull
import kotlinx.datetime.Clock.System.now
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.integrasjoner.brreg.BrregVirksomhetDto
import no.nav.lydia.integrasjoner.brreg.NæringsundergruppeBrreg
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Ny
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer.OppdateringVirksomhet
import no.nav.lydia.sykefraversstatistikk.import.KeySykefraversstatistikkMetadataVirksomhet
import no.nav.lydia.sykefraversstatistikk.import.KeySykefraversstatistikkPerKategori
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkMetadataVirksomhetImportDto
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto
import org.apache.kafka.clients.CommonClientConfigs
import org.apache.kafka.clients.admin.AdminClient
import org.apache.kafka.clients.admin.AdminClientConfig.BOOTSTRAP_SERVERS_CONFIG
import org.apache.kafka.clients.admin.NewTopic
import org.apache.kafka.clients.admin.OffsetSpec
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


class KafkaContainerHelper(
        network: Network = Network.newNetwork(),
        log: Logger = LoggerFactory.getLogger(KafkaContainerHelper::class.java),
) {
    companion object {
        const val statistikkMetadataVirksomhetTopic = "arbeidsgiver.sykefravarsstatistikk-metadata-virksomhet-v1"
        const val statistikkLandTopic = "arbeidsgiver.sykefravarsstatistikk-land-v1"
        const val statistikkSektorTopic = "arbeidsgiver.sykefravarsstatistikk-sektor-v1"
        const val statistikkNæringTopic = "arbeidsgiver.sykefravarsstatistikk-naring-v1"
        const val statistikkNæringskodeTopic = "arbeidsgiver.sykefravarsstatistikk-naringskode-v1"
        const val statistikkVirksomhetTopic = "arbeidsgiver.sykefravarsstatistikk-virksomhet-v1"
        const val iaSakTopic = "pia.ia-sak-v1"
        const val iaSakStatistikkTopic = "pia.ia-sak-statistikk-v1"
        const val iaSakStatusTopic = "pia.ia-sak-status-v1"
        const val iaSakLeveranseTopic = "pia.ia-sak-leveranse-v1"
        const val brregOppdateringTopic = "pia.brreg-oppdatering"
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
                        statistikkMetadataVirksomhetTopic,
                        statistikkLandTopic,
                        statistikkSektorTopic,
                        statistikkVirksomhetTopic)
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
                    statistikkNæringTopic = statistikkNæringTopic,
                    statistikkNæringskodeTopic = statistikkNæringskodeTopic,
                    statistikkVirksomhetTopic = statistikkVirksomhetTopic,
                    brregOppdateringTopic = brregOppdateringTopic,
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
            "STATISTIKK_NARING_TOPIC" to statistikkNæringTopic,
            "STATISTIKK_NARINGSKODE_TOPIC" to statistikkNæringskodeTopic,
            "STATISTIKK_VIRKSOMHET_TOPIC" to statistikkVirksomhetTopic,
            "IA_SAK_TOPIC" to iaSakTopic,
            "IA_SAK_STATISTIKK_TOPIC" to iaSakStatistikkTopic,
            "IA_SAK_STATUS_TOPIC" to iaSakStatusTopic,
            "IA_SAK_LEVERANSE_TOPIC" to iaSakLeveranseTopic,
            "BRREG_OPPDATERING_TOPIC" to brregOppdateringTopic
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
    ) {
        runBlocking {
            val sendteMeldinger = importDtoer.map { melding ->
                kafkaProducer.send(melding.tilProducerRecord()).get()
            }
            ventTilKonsumert(
                    konsumentGruppeId = Kafka.statistikkPerKategoriGroupId,
                    recordMetadata = sendteMeldinger.last()
            )
        }
    }

    fun sendBrregOppdatering(testVirksomhet: TestVirksomhet) {

        runBlocking {
            val sendtMelding =
                    kafkaProducer.send(
                            testVirksomhet.tilProducerRecord()
                    ).get()

            ventTilKonsumert(
                    konsumentGruppeId = Kafka.brregConsumerGroupId,
                    recordMetadata = sendtMelding
            )
        }
    }

    suspend fun ventTilAlleMeldingerErKonsumert(
            konsumentGruppe: String,
            timeout: Duration = Duration.ofSeconds(10)
    ) {
        withTimeout(timeout) {
            var topicOffset: Pair<String, Long>?
            do {
                delay(timeMillis = 10L)
                val offsetMetadata = adminClient.listConsumerGroupOffsets(konsumentGruppe)
                        .partitionsToOffsetAndMetadata().get()

                topicOffset = adminClient.listOffsets(offsetMetadata.mapValues {
                    OffsetSpec.latest()
                }).all().get().map { Pair(it.key.topic(), it.value.offset()) }.firstOrNull()
            } while (topicOffset == null)

            do {
                delay(timeMillis = 10L)
            } while (topicOffset.second - consumerSinOffset(consumerGroup = konsumentGruppe, topic = topicOffset.first) != 0L)
        }
    }

    private fun TestVirksomhet.tilProducerRecord(): ProducerRecord<String, String> {
        val oppdateringVirksomhet = OppdateringVirksomhet(
                orgnummer = this.orgnr,
                oppdateringsid = 100001L,
                endringstype = Ny,
                metadata = BrregVirksomhetDto(
                        organisasjonsnummer = this.orgnr,
                        oppstartsdato = "2023-01-01",
                        navn = this.navn,
                        beliggenhetsadresse = this.beliggenhet,
                        naeringskode1 = NæringsundergruppeBrreg(
                                kode = this.næringsundergruppe1.kode,
                                beskrivelse = this.næringsundergruppe1.navn
                        ),
                        naeringskode2 =
                        if (this.næringsundergruppe2 != null) {
                            NæringsundergruppeBrreg(
                                    kode = this.næringsundergruppe2.kode,
                                    beskrivelse = this.næringsundergruppe2.navn
                            )
                        } else {
                            null
                        },
                        naeringskode3 =
                        if (this.næringsundergruppe3 != null) {
                            NæringsundergruppeBrreg(
                                    kode = this.næringsundergruppe3.kode,
                                    beskrivelse = this.næringsundergruppe3.navn
                            )
                        } else {
                            null
                        },
                ),
                endringstidspunkt = now()
        )
        return ProducerRecord(
                brregOppdateringTopic,
                this.orgnr,
                Json.encodeToString(
                        oppdateringVirksomhet
                )
        )
    }

    private fun SykefraversstatistikkPerKategoriImportDto.tilProducerRecord() =
            ProducerRecord(
                    statistikkVirksomhetTopic,
                    gson.toJson(
                            KeySykefraversstatistikkPerKategori(
                                    kategori = kategori.name,
                                    kode = kode,
                                    årstall = sistePubliserteKvartal.årstall,
                                    kvartal = sistePubliserteKvartal.kvartal
                            ),
                    ),
                    gson.toJson(this)
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
                } while (consumerSinOffset(consumerGroup = konsumentGruppeId, topic = recordMetadata.topic()) <= recordMetadata.offset())
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
