package no.nav.lydia.helper

import no.nav.lydia.Kafka.Companion.statistikkTopic
import org.apache.kafka.clients.CommonClientConfigs
import org.apache.kafka.clients.admin.AdminClient
import org.apache.kafka.clients.admin.AdminClientConfig.BOOTSTRAP_SERVERS_CONFIG
import org.apache.kafka.clients.admin.NewTopic
import org.apache.kafka.clients.producer.KafkaProducer
import org.apache.kafka.clients.producer.ProducerConfig
import org.apache.kafka.common.config.SaslConfigs
import org.apache.kafka.common.serialization.StringSerializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.KafkaContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.utility.DockerImageName


class KafkaContainerHelper(network: Network = Network.newNetwork(), log: Logger = LoggerFactory.getLogger(KafkaContainerHelper::class.java)) {
    private val kafkaNetworkAlias = "kafkaContainer"
    val kafkaContainer = KafkaContainer(DockerImageName.parse("confluentinc/cp-kafka:6.2.1"))
        .withNetwork(network)
        .withNetworkAliases(kafkaNetworkAlias)
        .withExposedPorts(9092, 9093, KafkaContainer.ZOOKEEPER_PORT)
        .withLogConsumer(Slf4jLogConsumer(log).withPrefix(kafkaNetworkAlias).withSeparateOutputStreams())
        .waitingFor(HostPortWaitStrategy())
        .apply {
            this.addEnv("KAFKA_ADVERTISED_LISTENERS", "BROKER://$kafkaNetworkAlias:9092,PLAINTEXT://$kafkaNetworkAlias:9092")
            this.start()
            this.createTopic(statistikkTopic)
        }

    fun envVars() = mapOf(
        "KAFKA_BROKERS" to "BROKER://$kafkaNetworkAlias:9092,PLAINTEXT://$kafkaNetworkAlias:9092"
    )

    private fun KafkaContainer.createTopic(vararg topics: String) {
        val newTopics = topics
            .map { topic -> NewTopic(topic, 1, 1.toShort()) }
        AdminClient.create(mapOf(BOOTSTRAP_SERVERS_CONFIG to this.bootstrapServers)).use { admin ->
            admin.createTopics(
                newTopics
            )
        }
    }

    fun producer(bootstrapServers: String = kafkaContainer.bootstrapServers): KafkaProducer<String, String> =
        KafkaProducer(
        mapOf(
            CommonClientConfigs.BOOTSTRAP_SERVERS_CONFIG to bootstrapServers,
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
}