package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.responseObject
import io.kotest.matchers.equality.shouldBeEqualToComparingFields
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.DbTestHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.runMigration
import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkImportDto
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkImportTest {
    val postgres = TestContainerHelper.postgresContainer
    val lydiaApi = TestContainerHelper.lydiaApiContainer
    val mockOauthContaier = TestContainerHelper.oauth2ServerContainer
    val dataSource = DbTestHelper.getDataSource(postgresContainer = postgres).apply {
        runMigration(this)
    }
    val sykefraversstatistikkRepository = SykefraversstatistikkRepository(dataSource)

    @Test
    fun `importerte data skal kunne hentes ut`() {
        val testOrgnr = "910969439"
        // Send inn data
        sykefraversstatistikkRepository.insert(
            sykefraversstatistikkVirksomhet = SykefraversstatistikkImportDto(
                orgnr = testOrgnr,
                arstall = 2021,
                kvartal = 4,
                antallPersoner = 10.0,
                tapteDagsverk = 219.078753,
                muligeDagsverk = 1026.185439,
                sykefraversprosent = 20.0,
                maskert = false
            )
        )

        // Hent ut sykefraværsstatistikk
        val sykefravær = sykefraversstatistikkRepository.hentSykefravær(testOrgnr)
        sykefravær.size shouldBe 1

         val (_, _, result) = lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$testOrgnr")
             .authentication().bearer(mockOauthContaier.lydiaApiToken)
             .responseObject<List<SykefraversstatistikkVirksomhetDto>>()

        result.fold(success = { dto ->
            dto.size shouldBeExactly 1
            dto[0] shouldBeEqualToComparingFields sykefravær[0].toDto()
        }, failure = {
            fail(it.message)
        })
    }

}