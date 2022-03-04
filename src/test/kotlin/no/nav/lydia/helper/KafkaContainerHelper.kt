package no.nav.lydia.helper

import SykefraversstatistikkKafkaMelding
import com.google.gson.GsonBuilder
import kotlinx.coroutines.delay
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.time.withTimeoutOrNull
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_CESNAUSKAITE_oslo
import no.nav.lydia.helper.IntegrationsHelper.Companion.orgnr_smileyprosjekter_bergen
import no.nav.lydia.sykefraversstatistikk.api.Periode
import org.apache.kafka.clients.CommonClientConfigs
import org.apache.kafka.clients.admin.AdminClient
import org.apache.kafka.clients.admin.AdminClientConfig.BOOTSTRAP_SERVERS_CONFIG
import org.apache.kafka.clients.admin.NewTopic
import org.apache.kafka.clients.producer.KafkaProducer
import org.apache.kafka.clients.producer.ProducerConfig
import org.apache.kafka.clients.producer.ProducerRecord
import org.apache.kafka.common.config.SaslConfigs
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
    log: Logger = LoggerFactory.getLogger(KafkaContainerHelper::class.java)
) {
    private val gson = GsonBuilder().create()
    private val kafkaNetworkAlias = "kafkaContainer"
    val statistikkTopic = "arbeidsgiver.sykefravarsstatistikk-v1"
    private var adminClient: AdminClient
    private var kafkaProducer: KafkaProducer<String, String>

    val kafkaContainer = KafkaContainer(
        DockerImageName.parse("kymeric/cp-kafka")
            .asCompatibleSubstituteFor("confluentinc/cp-kafka")
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
            createTopic(statistikkTopic)
            kafkaProducer = producer()
        }

    fun envVars() = mapOf(
        "KAFKA_BROKERS" to "BROKER://$kafkaNetworkAlias:9092,PLAINTEXT://$kafkaNetworkAlias:9092",
        "KAFKA_TRUSTSTORE_PATH" to "",
        "KAFKA_KEYSTORE_PATH" to "",
        "KAFKA_CREDSTORE_PASSWORD" to "",
        "STATISTIKK_TOPIC" to statistikkTopic
    )

    private fun KafkaContainer.createTopic(vararg topics: String) {
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

    fun sykefraversstatistikkKafkaMelding(melding: Melding): SykefraversstatistikkKafkaMelding {
        return gson.fromJson(melding.melding, SykefraversstatistikkKafkaMelding::class.java)
    }

    fun sendSykefraversstatistikkKafkaMelding(melding: Melding) {
        val kafkaMelding = sykefraversstatistikkKafkaMelding(melding)
        sendOgVentTilKonsumert(
            key = gson.toJson(kafkaMelding.key), value = gson.toJson(kafkaMelding.value)
        )
    }

    fun sendOgVentTilKonsumert(topic: String = statistikkTopic,
        key: String, value: String, timeout: Duration = Duration.ofSeconds(5)
    ) {
        runBlocking {
            val sendtMelding = kafkaProducer.send(
                ProducerRecord(
                    topic,
                    key,
                    value
                )
            ).get()

            withTimeoutOrNull(timeout) {
                do {
                    delay(timeMillis = 250L)
                } while (consumerSinOffset("lydiaApiStatistikkConsumers") <= sendtMelding.offset())
            }
        }
    }

    private fun consumerSinOffset(consumerGroup: String): Long {
        val offsetMetadata = adminClient.listConsumerGroupOffsets(consumerGroup)
            .partitionsToOffsetAndMetadata().get()
        return offsetMetadata[offsetMetadata.keys.firstOrNull()]?.offset() ?: -1
    }

}

enum class Melding(val melding: String) {
    osloForrigeKvartal(melding = """
        {
          "key": {
            "orgnr": $orgnr_CESNAUSKAITE_oslo,
            "kvartal": ${Periode.forrigePeriode().kvartal},
            "årstall": ${Periode.forrigePeriode().årstall}
          },
          "value": {
            "virksomhetSykefravær": {
              "orgnr": "987654321",
              "navn": "Virksomhet Oslo",
              "årstall": ${Periode.forrigePeriode().årstall},
              "kvartal": ${Periode.forrigePeriode().kvartal},
              "tapteDagsverk": 10.0,
              "muligeDagsverk": 500.0,
              "antallPersoner": 6,
              "prosent": 2.0,
              "erMaskert": false,
              "kategori": "VIRKSOMHET"
            },
            "næring5SifferSykefravær": [
              {
                "kategori": "NÆRING5SIFFER",
                "kode": "11000",
                "årstall": ${Periode.forrigePeriode().årstall},
                "kvartal": ${Periode.forrigePeriode().kvartal},
                "tapteDagsverk": "40.0",
                "muligeDagsverk": 4000.0,
                "antallPersoner": 1250,
                "prosent": 1.0,
                "erMaskert": false
              }
            ],
            "næringSykefravær": {
              "kategori": "NÆRING2SIFFER",
              "kode": "11",
              "årstall": ${Periode.forrigePeriode().årstall},
              "kvartal": ${Periode.forrigePeriode().kvartal},
              "tapteDagsverk": "100.0",
              "muligeDagsverk": 5000.0,
              "antallPersoner": 150,
              "prosent": 2.0,
              "erMaskert": false
            },
            "sektorSykefravær": {
              "kategori": "SEKTOR",
              "kode": "1",
              "årstall": ${Periode.forrigePeriode().årstall},
              "kvartal": ${Periode.forrigePeriode().kvartal},
              "tapteDagsverk": "1340.0",
              "muligeDagsverk": 88000.0,
              "antallPersoner": 33000,
              "prosent": 1.5,
              "erMaskert": false
            },
            "landSykefravær": {
              "kategori": "LAND",
              "kode": "NO",
              "årstall": ${Periode.forrigePeriode().årstall},
              "kvartal": ${Periode.forrigePeriode().kvartal},
              "tapteDagsverk": "10000000.0",
              "muligeDagsverk": 500000000.0,
              "antallPersoner": 2500000,
              "prosent": 2.0,
              "erMaskert": false
            }
          }
        }
    """.trimIndent()),
    osloGjeldeneKvartal(melding = """
        {
          "key": {
            "orgnr": $orgnr_CESNAUSKAITE_oslo,
            "kvartal": ${Periode.gjeldenePeriode().kvartal},
            "årstall": ${Periode.gjeldenePeriode().årstall}
          },
          "value": {
            "virksomhetSykefravær": {
              "orgnr": "987654321",
              "navn": "Virksomhet Oslo",
              "årstall": ${Periode.gjeldenePeriode().årstall},
              "kvartal": ${Periode.gjeldenePeriode().kvartal},
              "tapteDagsverk": 10.0,
              "muligeDagsverk": 500.0,
              "antallPersoner": 6,
              "prosent": 2.0,
              "erMaskert": false,
              "kategori": "VIRKSOMHET"
            },
            "næring5SifferSykefravær": [
              {
                "kategori": "NÆRING5SIFFER",
                "kode": "11000",
                "årstall": ${Periode.gjeldenePeriode().årstall},
                "kvartal": ${Periode.gjeldenePeriode().kvartal},
                "tapteDagsverk": "40.0",
                "muligeDagsverk": 4000.0,
                "antallPersoner": 1250,
                "prosent": 1.0,
                "erMaskert": false
              }
            ],
            "næringSykefravær": {
              "kategori": "NÆRING2SIFFER",
              "kode": "11",
              "årstall": ${Periode.gjeldenePeriode().årstall},
              "kvartal": ${Periode.gjeldenePeriode().kvartal},
              "tapteDagsverk": "100.0",
              "muligeDagsverk": 5000.0,
              "antallPersoner": 150,
              "prosent": 2.0,
              "erMaskert": false
            },
            "sektorSykefravær": {
              "kategori": "SEKTOR",
              "kode": "1",
              "årstall": ${Periode.gjeldenePeriode().årstall},
              "kvartal": ${Periode.gjeldenePeriode().kvartal},
              "tapteDagsverk": "1340.0",
              "muligeDagsverk": 88000.0,
              "antallPersoner": 33000,
              "prosent": 1.5,
              "erMaskert": false
            },
            "landSykefravær": {
              "kategori": "LAND",
              "kode": "NO",
              "årstall": ${Periode.gjeldenePeriode().årstall},
              "kvartal": ${Periode.gjeldenePeriode().kvartal},
              "tapteDagsverk": "10000000.0",
              "muligeDagsverk": 500000000.0,
              "antallPersoner": 2500000,
              "prosent": 2.0,
              "erMaskert": false
            }
          }
        }
    """.trimIndent()),
    bergenForrigeKvartal(melding = """
        {
          "key": {
            "orgnr": $orgnr_smileyprosjekter_bergen,
            "kvartal": ${Periode.forrigePeriode().kvartal},
            "årstall": ${Periode.forrigePeriode().årstall}
          },
          "value": {
            "virksomhetSykefravær": {
              "orgnr": "995858266",
              "navn": "Virksomhet Bergen",
              "årstall": ${Periode.forrigePeriode().årstall},
              "kvartal": ${Periode.forrigePeriode().kvartal},
              "tapteDagsverk": 20.0,
              "muligeDagsverk": 500.0,
              "antallPersoner": 6,
              "prosent": 2.0,
              "erMaskert": false,
              "kategori": "VIRKSOMHET"
            },
            "næring5SifferSykefravær": [
              {
                "kategori": "NÆRING5SIFFER",
                "kode": "11000",
                "årstall": ${Periode.forrigePeriode().årstall},
                "kvartal": ${Periode.forrigePeriode().kvartal},
                "tapteDagsverk": "40.0",
                "muligeDagsverk": 4000.0,
                "antallPersoner": 1250,
                "prosent": 1.0,
                "erMaskert": false
              }
            ],
            "næringSykefravær": {
              "kategori": "NÆRING2SIFFER",
              "kode": "11",
              "årstall": ${Periode.forrigePeriode().årstall},
              "kvartal": ${Periode.forrigePeriode().kvartal},
              "tapteDagsverk": "100.0",
              "muligeDagsverk": 5000.0,
              "antallPersoner": 150,
              "prosent": 2.0,
              "erMaskert": false
            },
            "sektorSykefravær": {
              "kategori": "SEKTOR",
              "kode": "1",
              "årstall": ${Periode.forrigePeriode().årstall},
              "kvartal": ${Periode.forrigePeriode().kvartal},
              "tapteDagsverk": "1340.0",
              "muligeDagsverk": 88000.0,
              "antallPersoner": 33000,
              "prosent": 1.5,
              "erMaskert": false
            },
            "landSykefravær": {
              "kategori": "LAND",
              "kode": "NO",
              "årstall": ${Periode.forrigePeriode().årstall},
              "kvartal": ${Periode.forrigePeriode().kvartal},
              "tapteDagsverk": "10000000.0",
              "muligeDagsverk": 500000000.0,
              "antallPersoner": 2500000,
              "prosent": 2.0,
              "erMaskert": false
            }
          }
        }
    """.trimIndent()),
    bergenGjeldeneKvartal(melding = """
        {
          "key": {
            "orgnr": $orgnr_smileyprosjekter_bergen,
            "kvartal": ${Periode.gjeldenePeriode().kvartal},
            "årstall": ${Periode.gjeldenePeriode().årstall}
          },
          "value": {
            "virksomhetSykefravær": {
              "orgnr": "995858266",
              "navn": "Virksomhet Bergen",
              "årstall": ${Periode.gjeldenePeriode().årstall},
              "kvartal": ${Periode.gjeldenePeriode().kvartal},
              "tapteDagsverk": 20.0,
              "muligeDagsverk": 500.0,
              "antallPersoner": 6,
              "prosent": 2.0,
              "erMaskert": false,
              "kategori": "VIRKSOMHET"
            },
            "næring5SifferSykefravær": [
              {
                "kategori": "NÆRING5SIFFER",
                "kode": "11000",
                "årstall": ${Periode.gjeldenePeriode().årstall},
                "kvartal": ${Periode.gjeldenePeriode().kvartal},
                "tapteDagsverk": "40.0",
                "muligeDagsverk": 4000.0,
                "antallPersoner": 1250,
                "prosent": 1.0,
                "erMaskert": false
              }
            ],
            "næringSykefravær": {
              "kategori": "NÆRING2SIFFER",
              "kode": "11",
              "årstall": ${Periode.gjeldenePeriode().årstall},
              "kvartal": ${Periode.gjeldenePeriode().kvartal},
              "tapteDagsverk": "100.0",
              "muligeDagsverk": 5000.0,
              "antallPersoner": 150,
              "prosent": 2.0,
              "erMaskert": false
            },
            "sektorSykefravær": {
              "kategori": "SEKTOR",
              "kode": "1",
              "årstall": ${Periode.gjeldenePeriode().årstall},
              "kvartal": ${Periode.gjeldenePeriode().kvartal},
              "tapteDagsverk": "1340.0",
              "muligeDagsverk": 88000.0,
              "antallPersoner": 33000,
              "prosent": 1.5,
              "erMaskert": false
            },
            "landSykefravær": {
              "kategori": "LAND",
              "kode": "NO",
              "årstall": ${Periode.gjeldenePeriode().årstall},
              "kvartal": ${Periode.gjeldenePeriode().kvartal},
              "tapteDagsverk": "10000000.0",
              "muligeDagsverk": 500000000.0,
              "antallPersoner": 2500000,
              "prosent": 2.0,
              "erMaskert": false
            }
          }
        }
    """.trimIndent())
}
