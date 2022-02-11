package no.nav.lydia.helper

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import no.nav.lydia.getFlyway
import org.testcontainers.containers.PostgreSQLContainer
import java.sql.ResultSet
import java.sql.Statement
import javax.sql.DataSource

class DbTestHelper {

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

        fun cleanMigrate(dataSource: DataSource) {
            val flyway = getFlyway(dataSource)
            flyway.clean()
            flyway.migrate()
        }
    }

}