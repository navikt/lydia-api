package no.nav.lydia.container

import com.github.kittinunf.fuel.core.isSuccessful
import no.nav.lydia.container.helper.DbTestHelper.Companion.performQuery
import no.nav.lydia.container.helper.TestContainerHelper
import no.nav.lydia.container.helper.TestContainerHelper.Companion.performGet
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