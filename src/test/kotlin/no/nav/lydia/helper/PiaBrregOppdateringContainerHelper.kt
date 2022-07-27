package no.nav.lydia.helper

import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HttpWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import java.util.*

const val brregOppdateringTopic = "pia.brreg-oppdatering"

class PiaBrregOppdateringContainerHelper(
    network: Network = Network.newNetwork(),
    log: Logger = LoggerFactory.getLogger(PiaBrregOppdateringContainerHelper::class.java)
) {
        val brregOppdateringContainer: GenericContainer<*> =
            GenericContainer(ImageFromDockerfile().withDockerfileFromBuilder { builder ->
                builder.from("ghcr.io/navikt/pia-brreg-oppdaterer:latest")
                    .env(
                        mapOf(
                            "TZ" to TimeZone.getDefault().id
                        )
                    )
            })
                .dependsOn(
                    TestContainerHelper.kafkaContainerHelper.kafkaContainer,
                )
                .withLogConsumer(
                    Slf4jLogConsumer(log).withPrefix("brregOppdateringContainer").withSeparateOutputStreams()
                )
                .withNetwork(network)
                .withEnv(
                    TestContainerHelper.kafkaContainerHelper.envVars()
                        .plus(
                            mapOf(
                                "BRREG_UNDERENHET_URL" to "/brregmock/enhetsregisteret/api/underenheter/lastned",
                                "NAIS_CLUSTER_NAME" to "lokal",
                            )
                        )
                )
                .waitingFor(HttpWaitStrategy().forPath("/internal/isready")).apply {
                    start()
                }
}