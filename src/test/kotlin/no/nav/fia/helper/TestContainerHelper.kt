package no.nav.fia.helper

import com.github.kittinunf.fuel.core.Request
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.httpPost
import io.kotest.matchers.string.shouldContain
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

        val fiaApiContainer: GenericContainer<*> = GenericContainer(ImageFromDockerfile().withDockerfile(Path("./Dockerfile")))
            .dependsOn(kafkaContainerHelper.kafkaContainer, postgresContainer.postgresContainer, oauth2ServerContainer.mockOath2Server)
            .withLogConsumer(Slf4jLogConsumer(log).withPrefix("fiaApiContainer").withSeparateOutputStreams())
            .withNetwork(network)
            .withExposedPorts(8080)
            .withCreateContainerCmdModifier { cmd -> cmd.withName("fia-${System.currentTimeMillis()}") }
            .withEnv(
                postgresContainer.envVars()
                    .plus(oauth2ServerContainer.envVars())
                    .plus(kafkaContainerHelper.envVars()
                    .plus(mapOf(
                        "BRREG_UNDERENHET_URL" to "/brregmock/enhetsregisteret/api/underenheter/lastned",
                        "CONSUMER_LOOP_DELAY" to "10",
                        "SSB_NARINGS_URL" to "/naringmock/api/klass/v1/30/json",
                        "NAIS_CLUSTER_NAME" to "lokal",
                    ))))
            .waitingFor(HttpWaitStrategy().forPath("/internal/isready")).apply {
                start()
            }

        private fun GenericContainer<*>.buildUrl(url: String) = "http://${this.host}:${this.getMappedPort(8080)}/$url"
        fun GenericContainer<*>.performGet(url: String) = buildUrl(url = url).httpGet()
        fun GenericContainer<*>.performPost(url: String) = buildUrl(url = url).httpPost()

        fun Request.withFiaToken(): Request = this.authentication().bearer(oauth2ServerContainer.saksbehandler1.token)
        infix fun GenericContainer<*>.shouldContainLog(regex: Regex) = logs shouldContain regex
    }
}
