package no.nav.fia.helper

import SykefraversstatistikkKafkaMelding
import com.google.gson.GsonBuilder
import kotlinx.coroutines.delay
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.time.withTimeoutOrNull
import no.nav.fia.Kafka
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

    fun sykefraversstatistikkKafkaMelding(melding: String): SykefraversstatistikkKafkaMelding {
        return gson.fromJson(melding, SykefraversstatistikkKafkaMelding::class.java)
    }

    fun sendSykefraversstatistikkKafkaMelding(melding: String) {
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
                    delay(timeMillis = 10L)
                } while (consumerSinOffset(consumerGroup = Kafka.groupId) <= sendtMelding.offset())
            }
        }
    }

    private fun consumerSinOffset(consumerGroup: String): Long {
        val offsetMetadata = adminClient.listConsumerGroupOffsets(consumerGroup)
            .partitionsToOffsetAndMetadata().get()
        return offsetMetadata[offsetMetadata.keys.firstOrNull()]?.offset() ?: -1
    }

}
