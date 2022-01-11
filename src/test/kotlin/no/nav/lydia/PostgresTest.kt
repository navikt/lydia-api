package no.nav.lydia

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import org.testcontainers.containers.PostgreSQLContainer
import java.sql.ResultSet
import java.sql.Statement
import kotlin.test.Test
import kotlin.test.assertEquals

class PostgresTest {
    private val postgresContainer: PostgreSQLContainer<*> =
        PostgreSQLContainer("postgres:latest").apply {
            start()
        }

    @Test
    fun `Kan koble til testdatabase`() {
        assert(postgresContainer.isRunning)
        val resultSet = performQuery(postgresContainer, "SELECT 1")
        val resultSetInt = resultSet.getInt(1)
        assertEquals(1, resultSetInt)
    }

    private fun getDataSource(postgresContainer : PostgreSQLContainer<*>) =
        HikariDataSource(HikariConfig().apply {
            jdbcUrl = postgresContainer.jdbcUrl
            username = postgresContainer.username
            password = postgresContainer.password
        })

    private fun performQuery(container: PostgreSQLContainer<*>, sql: String): ResultSet {
        val statement: Statement = getDataSource(container).connection.createStatement()
        statement.execute(sql)
        val resultSet: ResultSet = statement.resultSet
        resultSet.next()
        return resultSet
    }
}