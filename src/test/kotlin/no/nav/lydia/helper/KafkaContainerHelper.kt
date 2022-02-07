package no.nav.lydia.helper

import org.slf4j.Logger
import org.testcontainers.containers.KafkaContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.utility.DockerImageName

class KafkaContainerHelper(network: Network, log: Logger) {
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
}