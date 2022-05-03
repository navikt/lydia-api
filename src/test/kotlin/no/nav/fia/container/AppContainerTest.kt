package no.nav.fia.container

import com.github.kittinunf.fuel.core.isSuccessful
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.string.shouldContain
import no.nav.fia.helper.TestContainerHelper
import no.nav.fia.helper.TestContainerHelper.Companion.performGet
import kotlin.test.Test
import kotlin.test.fail

class AppContainerTest {
    private val fiaApiContainer = TestContainerHelper.fiaApiContainer
    private val postgresContainer = TestContainerHelper.postgresContainer

    @Test
    fun `kaller isAlive`() {
        val (_, response, _) = fiaApiContainer.performGet("internal/isalive")
            .responseString()

        assert(response.isSuccessful)
    }

    @Test
    fun `fia skal ha satt opp databasen`() {
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
        result.shouldBeTrue()
    }

    @Test
    fun `fia skal kunne gi oss metrikker`() {
        val (_, response, result) = fiaApiContainer.performGet("metrics")
            .responseString()

        assert(response.isSuccessful)
        result.fold(success = { metrikker ->
            metrikker shouldContain "process_cpu_usage"
            metrikker shouldContain "jvm_memory_used_bytes"
            metrikker shouldContain "ktor_http_server_requests_active"
            metrikker shouldContain "hikaricp_connections_acquire_seconds_count"
        }, failure = {
            fail("")
        }
        )
    }

}