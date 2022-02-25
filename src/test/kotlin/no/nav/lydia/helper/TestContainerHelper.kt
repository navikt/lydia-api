package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.Request
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.httpGet
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HttpWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import kotlin.io.path.Path

class TestContainerHelper {
    companion object {
        private var log: Logger = LoggerFactory.getLogger(this::class.java)

        private val network = Network.newNetwork()

        val oauth2ServerContainer = AuthContainerHelper(network = network, log = log)

        val kafkaContainerHelper = KafkaContainerHelper(network = network, log = log)

        val postgresContainer = PostgrestContainerHelper(network = network, log = log)

        val lydiaApiContainer: GenericContainer<*> = GenericContainer(ImageFromDockerfile().withDockerfile(Path("./Dockerfile")))
            .dependsOn(kafkaContainerHelper.kafkaContainer, postgresContainer.postgresContainer, oauth2ServerContainer.mockOath2Server)
            .withLogConsumer(Slf4jLogConsumer(log).withPrefix("lydiaApiContainer").withSeparateOutputStreams())
            .withNetwork(network)
            .withExposedPorts(8080)
            .withCreateContainerCmdModifier { cmd -> cmd.withName("lydia-${System.currentTimeMillis()}") }
            .withEnv(
                postgresContainer.envVars()
                    .plus(oauth2ServerContainer.envVars())
                    .plus(kafkaContainerHelper.envVars()
                    .plus(mapOf(
                        "BRREG_UNDERENHET_URL" to "/brregmock/enhetsregisteret/api/underenheter/lastned",
                        "CONSUMER_LOOP_DELAY" to "200",
                        "SSB_NARINGS_URL" to "/naringmock/api/klass/v1/30/json"
                    ))))
            .waitingFor(HttpWaitStrategy().forPath("/internal/isready")).apply {
                start()
            }

        fun GenericContainer<*>.performGet(url: String): Request {
            val baseurl = "http://${this.host}:${this.getMappedPort(8080)}"
            return "$baseurl/$url".httpGet()
        }

        fun Request.withLydiaToken(): Request = this.authentication().bearer(oauth2ServerContainer.lydiaApiToken)
    }

}