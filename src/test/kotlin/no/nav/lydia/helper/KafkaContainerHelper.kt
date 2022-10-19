package no.nav.lydia.helper

import com.google.gson.GsonBuilder
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.time.withTimeout
import kotlinx.coroutines.time.withTimeoutOrNull
import no.nav.lydia.Kafka
import no.nav.lydia.helper.TestData.Companion.DYRKING_AV_KORN
import no.nav.lydia.helper.TestData.Companion.LANDKODE_NO
import no.nav.lydia.helper.TestData.Companion.NÆRING_JORDBRUK
import no.nav.lydia.helper.TestData.Companion.SEKTOR_STATLIG_FORVALTNING
import no.nav.lydia.sykefraversstatistikk.import.Key
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkImportDto
import org.apache.kafka.clients.CommonClientConfigs
import org.apache.kafka.clients.admin.AdminClient
import org.apache.kafka.clients.admin.AdminClientConfig.BOOTSTRAP_SERVERS_CONFIG
import org.apache.kafka.clients.admin.NewTopic
import org.apache.kafka.clients.admin.OffsetSpec
import org.apache.kafka.clients.consumer.KafkaConsumer
import org.apache.kafka.clients.producer.KafkaProducer
import org.apache.kafka.clients.producer.ProducerConfig
import org.apache.kafka.clients.producer.ProducerRecord
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
import java.util.TimeZone


class KafkaContainerHelper(
    network: Network = Network.newNetwork(),
    log: Logger = LoggerFactory.getLogger(KafkaContainerHelper::class.java)
) {
    companion object {
        const val statistikkTopic = "arbeidsgiver.sykefravarsstatistikk-v1"
        const val statistikkLandTopic = "arbeidsgiver.sykefravarsstatistikk-land-v1"
        const val iaSakHendelseTopic = "pia.ia-sak-hendelse-v1"
        const val iaSakTopic = "pia.ia-sak-v1"
    }

    private val gson = GsonBuilder().create()
    private val kafkaNetworkAlias = "kafkaContainer"
    private var adminClient: AdminClient
    private var kafkaProducer: KafkaProducer<String, String>

    val kafkaContainer = KafkaContainer(
        DockerImageName.parse("confluentinc/cp-kafka:7.2.2")
    )
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
            createTopic(statistikkTopic, iaSakHendelseTopic, iaSakTopic, brregOppdateringTopic, statistikkLandTopic)
            kafkaProducer = producer()
        }

    fun nyKonsument(consumerGroupId: String) =
        Kafka(
            brokers = kafkaContainer.bootstrapServers,
            iaSakHendelseTopic = iaSakHendelseTopic,
            iaSakTopic = iaSakTopic,
            statistikkTopic = statistikkTopic,
            statistikkLandTopic = statistikkLandTopic,
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
        "STATISTIKK_TOPIC" to statistikkTopic,
        "STATISTIKK_LAND_TOPIC" to statistikkLandTopic,
        "IA_SAK_HENDELSE_TOPIC" to iaSakHendelseTopic,
        "IA_SAK_TOPIC" to iaSakTopic,
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
            ventTilKonsumert(sendtMelding.offset(), konsumentGruppeId = konsumentGruppeId)
        }
    }

    fun sendIBulkOgVentTilKonsumert(importDtoer: List<SykefraversstatistikkImportDto>) {
        runBlocking {
            val sendteMeldinger = importDtoer.map { melding ->
                kafkaProducer.send(melding.tilProducerRecord()).get()
            }
            ventTilKonsumert(sendteMeldinger.last().offset())
        }
    }

    fun sendSykefraversstatistikkKafkaMelding(importDto: SykefraversstatistikkImportDto) {
        runBlocking {
            val sendtMelding = kafkaProducer.send(importDto.tilProducerRecord()).get()
            ventTilKonsumert(sendtMelding.offset())
        }
    }

    suspend fun ventTilAlleMeldingerErKonsumert(konsumentGruppe: String, timeout: Duration = Duration.ofSeconds(10)) {
        withTimeout(timeout) {
            var topicOffset: Long?
            do {
                delay(timeMillis = 10L)
                val offsetMetadata = adminClient.listConsumerGroupOffsets(konsumentGruppe)
                    .partitionsToOffsetAndMetadata().get()

                topicOffset = adminClient.listOffsets(offsetMetadata.mapValues {
                    OffsetSpec.latest()
                }).all().get().map { it.value.offset() }.firstOrNull()
            } while (topicOffset == null)

            do {
                delay(timeMillis = 10L)
            } while (topicOffset - consumerSinOffset(konsumentGruppe) != 0L)
        }
    }

    private fun SykefraversstatistikkImportDto.tilProducerRecord() =
        ProducerRecord(
            statistikkTopic, gson.toJson(
                Key(
                    orgnr = virksomhetSykefravær.orgnr,
                    årstall = virksomhetSykefravær.årstall,
                    kvartal = virksomhetSykefravær.kvartal
                ),
            ), gson.toJson(this)
        )

    private suspend fun ventTilKonsumert(
        offset: Long,
        konsumentGruppeId: String = Kafka.statistikkConsumerGroupId
    ) =
        withTimeoutOrNull(Duration.ofSeconds(5)) {
            do {
                delay(timeMillis = 10L)
            } while (consumerSinOffset(consumerGroup = konsumentGruppeId) <= offset)
        }

    suspend fun ventOgKonsumerKafkaMeldinger(key: String, konsument: KafkaConsumer<String, String>, block: (meldinger: List<String>) -> Unit) {
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

    private fun consumerSinOffset(consumerGroup: String): Long {
        val offsetMetadata = adminClient.listConsumerGroupOffsets(consumerGroup)
            .partitionsToOffsetAndMetadata().get()
        return offsetMetadata[offsetMetadata.keys.firstOrNull()]?.offset() ?: -1
    }

    fun sendKafkameldingSomString(
        orgnr: String = "900000111",
        næringskode: String = NÆRING_JORDBRUK,
        næringsundergruppe: String = DYRKING_AV_KORN.kode,
        landKode: String = LANDKODE_NO,
        sektorkode: String = SEKTOR_STATLIG_FORVALTNING
    ) {
        runBlocking {
            val sendtMelding = kafkaProducer.send(
                ProducerRecord(
                    statistikkTopic,
                    """
            {
                "kvartal": 1,
                "årstall": 2019,
                "orgnr": "$orgnr"
            }
            """.trimIndent(),
                    """
             {
                "næringSykefravær": {
                  "kvartal": 1,
                  "prosent": 5.0,
                  "muligeDagsverk": 100.0,
                  "årstall": 2019,
                  "kode": "$næringskode",
                  "antallPersoner": 10.0,
                  "kategori": "NÆRING2SIFFER",
                  "tapteDagsverk": 5.0,
                  "maskert": false
                },
                "næring5SifferSykefravær": [
                  {
                    "kvartal": 1,
                    "prosent": 5.0,
                    "muligeDagsverk": 100.0,
                    "årstall": 2019,
                    "kode": "$næringsundergruppe",
                    "antallPersoner": 10.0,
                    "kategori": "NÆRING5SIFFER",
                    "tapteDagsverk": 5.0,
                    "maskert": false
                  }
                ],
                "virksomhetSykefravær": {
                  "kvartal": 1,
                  "prosent": 5.0,
                  "muligeDagsverk": 100.0,
                  "årstall": 2019,
                  "antallPersoner": 10.0,
                  "orgnr": "$orgnr",
                  "tapteDagsverk": 5.0,
                  "maskert": false,
                  "kategori": "VIRKSOMHET"
                },
                "landSykefravær": {
                  "kvartal": 1,
                  "prosent": 5.0,
                  "muligeDagsverk": 100.0,
                  "årstall": 2019,
                  "kode": "$landKode",
                  "antallPersoner": 10.0,
                  "kategori": "LAND",
                  "tapteDagsverk": 5.0,
                  "maskert": false
                },
                "sektorSykefravær": {
                  "kvartal": 1,
                  "prosent": 5.0,
                  "muligeDagsverk": 100.0,
                  "årstall": 2019,
                  "kode": "$sektorkode",
                  "antallPersoner": 10.0,
                  "kategori": "SEKTOR",
                  "tapteDagsverk": 5.0,
                  "maskert": false
                }
              }   
            """.trimIndent()
                )
            ).get()
            ventTilKonsumert(sendtMelding.offset())
        }
    }

}
