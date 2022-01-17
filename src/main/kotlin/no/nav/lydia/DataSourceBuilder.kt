package no.nav.lydia

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import io.ktor.http.*
import org.flywaydb.core.Flyway
import org.postgresql.ds.PGSimpleDataSource
import java.util.*
import javax.sql.DataSource

fun createDataSource(database: Database): DataSource {
    return HikariDataSource().apply {
        dataSourceClassName = PGSimpleDataSource::class.qualifiedName
        addDataSourceProperty("serverName", database.host)
        addDataSourceProperty("portNumber", database.port)
        addDataSourceProperty("user", database.username)
        addDataSourceProperty("password", database.password)
        addDataSourceProperty("databaseName", database.name)
        maximumPoolSize = 3
        minimumIdle = 1
        idleTimeout = 100000
        connectionTimeout = 100000
        maxLifetime = 300000
    }
}

fun runMigration(dataSource: DataSource) {
    Flyway.configure()
        .dataSource(dataSource)
        .load()
        .migrate()
}

enum class Role {
    Admin, User, ReadOnly;

    override fun toString() = name.lowercase(Locale.getDefault())
}
