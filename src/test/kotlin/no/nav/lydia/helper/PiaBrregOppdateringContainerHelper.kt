package no.nav.lydia.helper

import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.LogMessageWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import java.util.TimeZone

const val brregOppdateringTopic = "pia.brreg-oppdatering"
const val brregOppdaterteUnderenheterMockPath = "/brregmock/api/oppdateringer/underenheter"
const val brregUnderenheterMockPath = "/brregmock/api/underenheter"

class PiaBrregOppdateringContainerHelper(
    httpMock: HttpMock,
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
                            "BRREG_OPPDATERING_UNDERENHET_URL" to "http://host.testcontainers.internal:${httpMock.wireMockServer.port()}$brregOppdaterteUnderenheterMockPath",
                            "BRREG_UNDERENHET_URL" to "http://host.testcontainers.internal:${httpMock.wireMockServer.port()}$brregUnderenheterMockPath",
                            "NAIS_CLUSTER_NAME" to "lokal",
                        )
                    )
            )

    fun start() =
        brregOppdateringContainer
            .waitingFor(
                LogMessageWaitStrategy().withRegEx(".*Sendte oppdatering.*\\n")
            )
            .apply {
                start()
            }
}
