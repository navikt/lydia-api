package no.nav.lydia.container

import com.github.kittinunf.fuel.core.isSuccessful
import com.github.kittinunf.fuel.httpGet
import no.nav.lydia.container.DbTestUtil.Companion.performQuery
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import kotlin.io.path.Path
import kotlin.test.Test
import kotlin.test.assertTrue

class AppContainerTest {

    var log: Logger = LoggerFactory.getLogger(this::class.java)
    private val logConsumer = Slf4jLogConsumer(log).withSeparateOutputStreams()

    val network = Network.newNetwork()
    val postgresNetworkAlias = "postgrescontainer"
    val lydiaDbName = "lydia-api-container-db"
    val db_admin = "$lydiaDbName-admin" // Flyway forventer en admin-bruker for å kjøre migrering. Burde vi hatt en vanlig bruker her også?
    private val postgresContainer: PostgreSQLContainer<*> =
        PostgreSQLContainer("postgres:12")
            .withLogConsumer(logConsumer)
            .withNetwork(network)
            .withNetworkAliases(postgresNetworkAlias)
            .withDatabaseName(lydiaDbName)
            .withUsername(db_admin)
            .waitingFor(
                HostPortWaitStrategy()
            )

    private val lydiaApiContainer = GenericContainer(
        ImageFromDockerfile().withDockerfile(Path("./Dockerfile"))
    )
        .withLogConsumer(logConsumer)
        .withNetwork(network)
        .withExposedPorts(8080)


    init {
        postgresContainer.start()

        lydiaApiContainer.withEnv(
            mapOf(
                "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_URL" to "jdbc:postgresql://$postgresNetworkAlias:5432/$lydiaDbName?loggerLevel=OFF",
                "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_USERNAME" to postgresContainer.getUsername(),
                "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PASSWORD" to postgresContainer.getPassword(),
                "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_DATABASE" to lydiaDbName,
            )
        )
        lydiaApiContainer.start()
    }

    @Test
    fun `Kaller isAlive`() {
        val (_, response, _) = "http://${lydiaApiContainer.host}:${lydiaApiContainer.getMappedPort(8080)}/isAlive"
            .httpGet()
            .responseString()

        assert(response.isSuccessful)
    }

    @Test
    fun `Lydia skal ha satt opp databasen`() {
        val resultSet = postgresContainer.performQuery(
            """
            SELECT EXISTS(
                SELECT * 
                     FROM INFORMATION_SCHEMA.TABLES 
                     WHERE TABLE_SCHEMA = 'public' 
                     AND  TABLE_NAME = 'sykefravar_statistikk_virksomhet'
                )
        """.trimIndent()
        )
        val result = resultSet.getBoolean(1)
        assertTrue(result)
    }

}