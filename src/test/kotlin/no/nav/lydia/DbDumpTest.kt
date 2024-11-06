package no.nav.lydia

import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldStartWith
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.VirksomhetHelper
import org.junit.experimental.categories.Category
import kotlin.test.Test

class DbDumpTest {
    @Category(CommandLineOnlyTest::class) // OBS: ikke fjern denne ellers vil denne testen kjøre i CI (GitHub actions)
    @Test
    fun createTestDump() {
        VirksomhetHelper.lastInnStandardTestdata(500)
        val jdbcUrl = TestContainerHelper.postgresContainer.dataSource.jdbcUrl
        jdbcUrl shouldStartWith "jdbc:postgresql"
        val portOgDbNavn = getPortAndDBnameFromJdbcUrl(jdbcUrl)
        val port = portOgDbNavn.first
        val database = portOgDbNavn.second

        ProcessBuilder("./dump_local_container_db.sh", port, database, "localhost")
            .redirectOutput(ProcessBuilder.Redirect.INHERIT)
            .start()
            .waitFor()
    }

    @Test
    fun `finner port og db navn fra en Jdbc url`() {
        val jdbcUrl = "jdbc:postgresql://localhost:49255/lydia-api-container-db?loggerLevel=OFF"
        val results = getPortAndDBnameFromJdbcUrl(jdbcUrl)

        results.first shouldBe "49255"
        results.second shouldBe "lydia-api-container-db"
    }

    companion object {
        fun getPortAndDBnameFromJdbcUrl(jdbcUrl: String): Pair<String?, String?> {
            val regex = """jdbc:postgresql://localhost:(?<port>\d+)/(?<db>([a-z-]+)+)\?*""".toRegex()
            val matchResult = regex.find(jdbcUrl)!!

            val port = matchResult.groups["port"]?.value
            val db = matchResult.groups["db"]?.value

            return Pair(port, db)
        }
    }
}
