package no.nav.lydia.container

import com.github.kittinunf.fuel.core.isSuccessful
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import no.nav.lydia.appstatus.FEATURE_TOGGLE_TEST_PATH
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import kotlin.test.Test
import kotlin.test.fail

class AppContainerTest {
    private val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    private val postgresContainer = TestContainerHelper.postgresContainer

    @Test
    fun `kaller isAlive`() {
        val (_, response, _) = lydiaApiContainer.performGet("internal/isalive")
            .responseString()

        assert(response.isSuccessful)
    }

    @Test
    fun `lydia skal ha satt opp databasen`() {
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
    fun `lydia skal kunne gi oss metrikker`() {
        val (_, response, result) = lydiaApiContainer.performGet("metrics")
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

    @Test
    fun `unleash skal ha enablet featuretoggle`() {
        lydiaApiContainer.performGet(FEATURE_TOGGLE_TEST_PATH).response().second.statusCode shouldBe 200
    }
}
