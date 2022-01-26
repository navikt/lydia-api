package no.nav.lydia.container

import com.github.kittinunf.fuel.core.isSuccessful
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.string.shouldContain
import no.nav.lydia.helper.DbTestHelper.Companion.performQuery
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import kotlin.test.Test
import kotlin.test.fail

class AppContainerTest {
    private val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    private val postgresContainer = TestContainerHelper.postgresContainer

    @Test
    fun `Kaller isAlive`() {
        val (_, response, _) = lydiaApiContainer.performGet("internal/isalive")
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
        result.shouldBeTrue()
    }

    @Test
    fun `Lydia skal kunne gi oss metrikker`() {
        val (_, response, result) = lydiaApiContainer.performGet("metrics")
            .responseString()

        assert(response.isSuccessful)
        result.fold(success = { metrikker ->
            metrikker.shouldContain("process_cpu_usage")
            metrikker.shouldContain("jvm_memory_used_bytes")
            metrikker.shouldContain("ktor_http_server_requests_active")
        }, failure = {
            fail("")
        }
        )
    }

}