package no.nav.lydia.container.helper

import com.github.kittinunf.fuel.core.Request
import com.github.kittinunf.fuel.httpGet
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import kotlin.io.path.Path

class TestContainerHelper {

    companion object {
        private var log: Logger = LoggerFactory.getLogger(this::class.java)

        private val network = Network.newNetwork()

        val oauth2ServerContainer = AuthContainerHelper(network = network, log = log)

        private val postgresNetworkAlias = "postgrescontainer"
        private val lydiaDbName = "lydia-api-container-db"
        val postgresContainer: PostgreSQLContainer<*> =
            PostgreSQLContainer("postgres:12")
                .withLogConsumer(Slf4jLogConsumer(log).withPrefix("postgresContainer").withSeparateOutputStreams())
                .withNetwork(network)
                .withNetworkAliases(postgresNetworkAlias)
                .withDatabaseName(lydiaDbName)
                .waitingFor(
                    HostPortWaitStrategy()
                ).also {
                    it.start()
                }

        val lydiaApiContainer: GenericContainer<*> = GenericContainer(
            ImageFromDockerfile().withDockerfile(Path("./Dockerfile"))
        )
            .withLogConsumer(Slf4jLogConsumer(log).withPrefix("lydiaApiContainer").withSeparateOutputStreams())
            .withNetwork(network)
            .withExposedPorts(8080)

        init {
            lydiaApiContainer.withEnv(
                mapOf(
                    "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_HOST" to postgresNetworkAlias,
                    "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PORT" to "5432",
                    "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_USERNAME" to postgresContainer.username,
                    "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PASSWORD" to postgresContainer.password,
                    "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_DATABASE" to lydiaDbName,
                    "AZURE_APP_CLIENT_ID" to "lydia-api",
                    "AZURE_OPENID_CONFIG_ISSUER" to oauth2ServerContainer.issuerUrl,
                    "AZURE_OPENID_CONFIG_JWKS_URI" to oauth2ServerContainer.jwksUri
                )
            )
            lydiaApiContainer.start()
        }

        fun GenericContainer<*>.performGet(url: String): Request {
            val baseurl = "http://${this.host}:${this.getMappedPort(8080)}"
            return "$baseurl/$url".httpGet()
        }
    }

}