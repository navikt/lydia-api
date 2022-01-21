package no.nav.lydia.container.helper

import com.github.kittinunf.fuel.core.Request
import com.github.kittinunf.fuel.httpGet
import no.nav.lydia.getEnvVar
import no.nav.security.mock.oauth2.MockOAuth2Server
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.containers.wait.strategy.Wait
import org.testcontainers.images.builder.ImageFromDockerfile
import kotlin.io.path.Path

class TestContainerHelper {

    companion object {
        private var log: Logger = LoggerFactory.getLogger(this::class.java)
        private val logConsumer = Slf4jLogConsumer(log).withSeparateOutputStreams()

        private val network = Network.newNetwork()
        private val postgresNetworkAlias = "postgrescontainer"
        private val mockOauth2NetworkAlias = "oath2server"
        private val mockOauth2Port = "8100"
        private val lydiaDbName = "lydia-api-container-db"
        private val postgresContainer: PostgreSQLContainer<*> =
            PostgreSQLContainer("postgres:12")
                .withLogConsumer(logConsumer)
                .withNetwork(network)
                .withNetworkAliases(postgresNetworkAlias)
                .withDatabaseName(lydiaDbName)
                .waitingFor(
                    HostPortWaitStrategy()
                )

        // TODO lag metoder for å hente ut token med claims fra containeren
        private val mockOath2Server = GenericContainer(ImageFromDockerfile().withDockerfileFromBuilder { builder ->
            builder.from("ghcr.io/navikt/mock-oauth2-server:0.4.1")
                .env(mapOf(
                    "SERVER_PORT" to mockOauth2Port,
                    "SERVER_HOSTNAME" to mockOauth2NetworkAlias
                ))
        })
            .withNetwork(network)
            .withNetworkAliases(mockOauth2NetworkAlias)
            .waitingFor(Wait.defaultWaitStrategy())

        private val lydiaApiContainer = GenericContainer(
            ImageFromDockerfile().withDockerfile(Path("./Dockerfile"))
        )
            .withLogConsumer(logConsumer)
            .withNetwork(network)
            .withExposedPorts(8080)


        init {
            postgresContainer.start()
            mockOath2Server.start()
            lydiaApiContainer.withEnv(
                mapOf(
                    "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_HOST" to postgresNetworkAlias,
                    "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PORT" to "5432",
                    "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_USERNAME" to postgresContainer.username,
                    "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PASSWORD" to postgresContainer.password,
                    "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_DATABASE" to lydiaDbName,
                    "AZURE_APP_CLIENT_ID" to "lydia-api",
                    "AZURE_OPENID_CONFIG_JWKS_URI" to "http://$mockOauth2NetworkAlias:$mockOauth2Port/default/jwks",
                    "AZURE_OPENID_CONFIG_ISSUER" to "http://$mockOauth2NetworkAlias:$mockOauth2Port/default",
                )
            )
            lydiaApiContainer.start()
        }

        fun lydiaApiContainer() = lydiaApiContainer
        fun postgresContainer() = postgresContainer

        fun GenericContainer<*>.performGet(url: String): Request {
            val baseurl = "http://${this.host}:${this.getMappedPort(8080)}"
            return "$baseurl/$url".httpGet()
        }
    }

}