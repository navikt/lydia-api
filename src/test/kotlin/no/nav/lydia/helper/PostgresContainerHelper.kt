package no.nav.lydia.helper

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import io.kotest.matchers.shouldBe
import no.nav.lydia.runMigration
import org.slf4j.Logger
import org.testcontainers.containers.Network
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy

class PostgresContainerHelper(
    network: Network,
    log: Logger,
) {
    private val postgresNetworkAlias = "postgrescontainer"
    private val lydiaDbName = "lydia-api-container-db"
    private var migreringErKjørt = false
    val container: PostgreSQLContainer<*> = PostgreSQLContainer("postgres:14")
        .withNetwork(network)
        .withDatabaseName(lydiaDbName)
        .waitingFor(HostPortWaitStrategy())
        .withNetworkAliases(postgresNetworkAlias)
        .withCreateContainerCmdModifier { cmd -> cmd.withName("$postgresNetworkAlias-${System.currentTimeMillis()}") }
        .withLogConsumer(
            Slf4jLogConsumer(log)
                .withPrefix(postgresNetworkAlias)
                .withSeparateOutputStreams(),
        )
        .apply { start() }

    val dataSource = nyDataSource()

    fun nyDataSource() =
        HikariDataSource(
            HikariConfig().apply {
                jdbcUrl = container.jdbcUrl
                username = container.username
                password = container.password
            },
        ).also {
            if (!migreringErKjørt) {
                runMigration(it)
                migreringErKjørt = true
            }
        }

    fun <T> hentAlleRaderTilEnkelKolonne(sql: String): List<T> {
        dataSource.connection.use { connection ->
            val statement = connection.createStatement()
            statement.execute(sql)
            val rs = statement.resultSet
            val list = mutableListOf<T>()
            while (rs.next()) {
                list.add(rs.getObject(1) as T)
            }
            return list
        }
    }

    fun <T> hentEnkelKolonne(sql: String): T {
        dataSource.connection.use { connection ->
            val statement = connection.createStatement()
            statement.execute(sql)
            val rs = statement.resultSet
            rs.next()
            rs.row shouldBe 1
            return rs.getObject(1) as T
        }
    }

    fun performUpdate(sql: String) {
        dataSource.connection.use { connection ->
            connection.createStatement().use { statement ->
                statement.execute(sql)
            }
        }
    }

    fun envVars() =
        mapOf(
            "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_HOST" to postgresNetworkAlias,
            "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PORT" to "5432",
            "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_USERNAME" to container.username,
            "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PASSWORD" to container.password,
            "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_DATABASE" to lydiaDbName,
        )
}
