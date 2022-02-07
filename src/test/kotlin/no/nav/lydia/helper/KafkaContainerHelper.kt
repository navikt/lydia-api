package no.nav.lydia.helper

import org.apache.kafka.clients.CommonClientConfigs
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
import java.util.*

class KafkaContainerHelper(network: Network = Network.newNetwork(), log: Logger = LoggerFactory.getLogger(KafkaContainerHelper::class.java)) {
    private val kafkaNetworkAlias = "kafkaContainer"
    val kafkaContainer = KafkaContainer(DockerImageName.parse("confluentinc/cp-kafka:6.2.1"))
        .withNetwork(network)
        .withLogConsumer(Slf4jLogConsumer(log).withPrefix(kafkaNetworkAlias).withSeparateOutputStreams())
        .withNetworkAliases(kafkaNetworkAlias)
        .waitingFor(HostPortWaitStrategy())
        .apply {
            start()
        }

    fun envVars() = mapOf(
        "KAFKA_BROKERS" to kafkaContainer.bootstrapServers
    )

    fun producer(): KafkaProducer<String, String> =
        KafkaProducer(
        mapOf(
            CommonClientConfigs.BOOTSTRAP_SERVERS_CONFIG to kafkaContainer.bootstrapServers,
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