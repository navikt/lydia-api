package no.nav.lydia.sykefraværsstatistikk.import

import io.kotest.matchers.shouldBe
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils
import no.nav.lydia.sykefraværsstatistikk.import.SykefraværsstatistikkPerKategoriImportDto.Companion.filterPåKategoriSektorOgGyldigSektor
import no.nav.lydia.virksomhet.domene.Sektor
import kotlin.test.Test

class SykefraværsstatistikkPerKategoriImportDtoTest {

    @Test
    fun `filterPåKategoriSektorOgGyldigSektor filtrerer bort ugyldige sektorer`() {
        listOf(
            SykefraværsstatistikkPerKategoriImportDto(
                kategori = Kategori.SEKTOR,
                kode = "Not OK",
                sistePubliserteKvartal = sistePubliserteKvartal,
                siste4Kvartal = siste4Kvartal
            ),
            SykefraværsstatistikkPerKategoriImportDto(
                kategori = Kategori.SEKTOR,
                kode = Sektor.KOMMUNAL.name,
                sistePubliserteKvartal = sistePubliserteKvartal,
                siste4Kvartal = siste4Kvartal
            )
        ).filterPåKategoriSektorOgGyldigSektor().size shouldBe 1
    }

    @Test
    fun `filterPåKategoriSektorOgGyldigSektor filtrerer bort det som ikke er SEKTOR`() {
        listOf(
            SykefraværsstatistikkPerKategoriImportDto(
                kategori = Kategori.VIRKSOMHET,
                kode = "987654321",
                sistePubliserteKvartal = sistePubliserteKvartal,
                siste4Kvartal = siste4Kvartal
            ),
            SykefraværsstatistikkPerKategoriImportDto(
                kategori = Kategori.BRANSJE,
                kode = "BARNEHAGER",
                sistePubliserteKvartal = sistePubliserteKvartal,
                siste4Kvartal = siste4Kvartal
            )
        ).filterPåKategoriSektorOgGyldigSektor().size shouldBe 0
    }


    private val sistePubliserteKvartal: SistePubliserteKvartal =
        SistePubliserteKvartal(
            årstall = SykefraværsstatistikkImportTestUtils.KVARTAL_2023_1.årstall,
            kvartal = SykefraværsstatistikkImportTestUtils.KVARTAL_2023_1.kvartal,
            tapteDagsverk = 504339.8,
            muligeDagsverk = 10104849.1,
            prosent = 6.0,
            erMaskert = false,
            antallPersoner = 3000001
        )
    private val siste4Kvartal: Siste4Kvartal =
        Siste4Kvartal(
            tapteDagsverk = 31505774.2,
            muligeDagsverk = 578099000.3,
            prosent = 5.4,
            erMaskert = false,
            kvartaler = listOf(SykefraværsstatistikkImportTestUtils.KVARTAL_2023_1)
        )
}
