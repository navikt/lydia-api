package no.nav.lydia.container

import com.github.kittinunf.fuel.core.isSuccessful
import com.github.kittinunf.fuel.httpGet
import no.nav.lydia.NaisCluster
import no.nav.lydia.NaisEnvironment
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import kotlin.io.path.Path
import kotlin.test.Test

class AppContainerTest {

    val network = Network.newNetwork()
    private val postgresContainer: PostgreSQLContainer<*> =
        PostgreSQLContainer("postgres:12")
            .withDatabaseName("lydia-api-container-db")
            .withExposedPorts(5432)
            .withNetwork(network)
            .waitingFor(
                HostPortWaitStrategy()
            ).apply {
                start()
            }

    private val container = GenericContainer(
        ImageFromDockerfile()
            .withDockerfile(Path("./Dockerfile"))
    )
        .withExposedPorts(8080)
        .withNetwork(network)
        .apply {
            start()
        }

    @Test
    fun `Starter docker`() {
        assert(postgresContainer.isRunning)
        assert(container.isRunning)
    }

    @Test
    fun `Kaller isAlive`() {
        val (_, response, _) = "http://${container.host}:${container.getMappedPort(8080)}/isAlive"
            .httpGet()
            .responseString()

        assert(response.isSuccessful)
    }
}