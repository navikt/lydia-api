package no.nav.lydia

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import org.flywaydb.core.Flyway
import java.util.*
import javax.sql.DataSource

fun createDataSource(jdbcUrl: String, username: String, password: String): DataSource {
    return HikariDataSource(HikariConfig().apply {
        this.jdbcUrl = jdbcUrl
        this.username = username
        this.password = password
        maximumPoolSize = 3
        minimumIdle = 1
        idleTimeout = 100000
        connectionTimeout = 100000
        maxLifetime = 300000
    })
}

fun runMigration(databaseName: String, dataSource: DataSource) {
    val initSql = "SET ROLE \"$databaseName-${Role.Admin}\""
    Flyway.configure()
        .dataSource(dataSource)
        .initSql(initSql)
        .load()
        .migrate()
}

enum class Role {
    Admin, User, ReadOnly;
    override fun toString() = name.lowercase(Locale.getDefault())
}
