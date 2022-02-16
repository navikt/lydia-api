package no.nav.lydia.helper

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import no.nav.lydia.getFlyway
import no.nav.lydia.runMigration
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.Network
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.containers.wait.strategy.LogMessageWaitStrategy
import java.sql.ResultSet
import java.sql.Statement
import javax.sql.DataSource

class PostgrestContainerHelper(network: Network = Network.newNetwork(), log: Logger = LoggerFactory.getLogger(PostgrestContainerHelper::class.java)) {
    private val postgresNetworkAlias = "postgrescontainer"
    val lydiaDbName = "lydia-api-container-db"
    val postgresContainer: PostgreSQLContainer<*> =
        PostgreSQLContainer("postgres:12")
            .withLogConsumer(
                Slf4jLogConsumer(log).withPrefix(postgresNetworkAlias).withSeparateOutputStreams()
            )
            .withNetwork(network)
            .withNetworkAliases(postgresNetworkAlias)
            .withDatabaseName(lydiaDbName)
            .withCreateContainerCmdModifier { cmd -> cmd.withName("$postgresNetworkAlias-${System.currentTimeMillis()}") }
            .waitingFor(HostPortWaitStrategy()).apply {
                start()
            }

    fun getDataSource() =
        HikariDataSource(HikariConfig().apply {
            jdbcUrl = postgresContainer.jdbcUrl
            username = postgresContainer.username
            password = postgresContainer.password
        }).also {
            runMigration(it)
        }

    fun performQuery(sql: String): ResultSet {
        val statement: Statement = getDataSource().connection.createStatement()
        statement.execute(sql)
        val resultSet: ResultSet = statement.resultSet
        resultSet.next()
        return resultSet
    }

    fun cleanMigrate(dataSource: DataSource = getDataSource()) {
        val flyway = getFlyway(dataSource)
        flyway.clean()
        flyway.migrate()
    }


    fun envVars() = mapOf(
        "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_HOST" to postgresNetworkAlias,
        "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PORT" to "5432",
        "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_USERNAME" to postgresContainer.username,
        "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_PASSWORD" to postgresContainer.password,
        "NAIS_DATABASE_LYDIA_API_LYDIA_API_DB_DATABASE" to lydiaDbName
    )
}