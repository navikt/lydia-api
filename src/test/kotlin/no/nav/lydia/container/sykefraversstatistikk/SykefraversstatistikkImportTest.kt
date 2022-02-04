package no.nav.lydia.container.sykefraversstatistikk

import no.nav.lydia.helper.DbTestHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.runMigration
import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkImportDto
import kotlin.test.Test

class SykefraversstatistikkImportTest {
    val postgres = TestContainerHelper.postgresContainer
    val dataSource = DbTestHelper.getDataSource(postgresContainer = postgres).apply {
        runMigration(this)
    }
    val sykefraversstatistikkRepository = SykefraversstatistikkRepository(dataSource)

    @Test
    fun `Skal kunne hente sykefraværsstatistikk for en enkelt bedrift`() {
        // Send inn data
        sykefraversstatistikkRepository.insert(
            sykefraversstatistikkVirksomhet = SykefraversstatistikkImportDto(
                orgnr = "910969439",
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
        // TODO
    }

}