package no.nav.lydia.container

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import org.testcontainers.containers.PostgreSQLContainer
import java.sql.ResultSet
import java.sql.Statement

class DbTestUtil {

    companion object{
        fun getDataSource(postgresContainer: PostgreSQLContainer<*>) =
            HikariDataSource(HikariConfig().apply {
                jdbcUrl = postgresContainer.jdbcUrl
                username = postgresContainer.username
                password = postgresContainer.password
            })

        fun PostgreSQLContainer<*>.performQuery(sql: String): ResultSet {
            val statement: Statement = getDataSource(this).connection.createStatement()
            statement.execute(sql)
            val resultSet: ResultSet = statement.resultSet
            resultSet.next()
            return resultSet
        }
    }

}