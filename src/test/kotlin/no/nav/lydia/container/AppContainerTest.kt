package no.nav.lydia.container

import com.github.kittinunf.fuel.core.isSuccessful
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.debug.KAST_FEIL_ENDEPUNKT
import no.nav.lydia.ia.debug.KAST_FEIL_ENDEPUNKT_MELDING
import kotlin.test.Test
import kotlin.test.fail

class AppContainerTest {
    private val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    private val postgresContainer = TestContainerHelper.postgresContainer


    @Test
    fun `feil skal logges som error, med melding`() {
        lydiaApiContainer.performGet(KAST_FEIL_ENDEPUNKT).response().statuskode() shouldBe 500
        lydiaApiContainer shouldContainLog "$KAST_FEIL_ENDEPUNKT_MELDING.*\"level\":\"ERROR\".*$".toRegex()
    }

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
}
