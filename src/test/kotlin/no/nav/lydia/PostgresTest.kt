package no.nav.lydia

import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.utility.DockerImageName
import java.sql.Connection
import java.sql.DriverManager
import java.sql.SQLException
import kotlin.jvm.Throws
import kotlin.test.BeforeTest
import kotlin.test.Test


class PostgresTest {

    val POSTGRES_PORT = 5432
    val POSTGRES_IMAGE = DockerImageName.parse("postgres:latest")

    val postgresContainer : PostgreSQLContainer<*> =
        PostgreSQLContainer<Nothing>(POSTGRES_IMAGE)
            .withExposedPorts(POSTGRES_PORT)



    @BeforeTest
    fun setup() {
        postgresContainer.start()
    }

    @Test
    fun `test database connection`(){
        val connection = getPostgresConnection(postgresContainer)
    }

    private fun getPostgresConnection(postgresContainer : PostgreSQLContainer<*>) =
        DriverManager.getConnection(
                postgresContainer.jdbcUrl,
                postgresContainer.username,
                postgresContainer.password
        )

}