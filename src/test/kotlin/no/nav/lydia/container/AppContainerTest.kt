package no.nav.lydia.container

import com.github.kittinunf.fuel.core.isSuccessful
import com.github.kittinunf.fuel.httpGet
import no.nav.lydia.container.DbTestUtil.Companion.performQuery
import no.nav.lydia.container.TestContainerHelper.Companion.performGet
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import java.sql.Connection
import kotlin.io.path.Path
import kotlin.test.Test
import kotlin.test.assertTrue

class AppContainerTest {
    private val lydiaApiContainer = TestContainerHelper.lydiaApiContainer()
    private val postgresContainer = TestContainerHelper.postgresContainer()

    @Test
    fun `Kaller isAlive`() {
        val (_, response, _) = lydiaApiContainer.performGet("isAlive")
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