package no.nav.lydia.container.sykefraversstatistikk

import io.kotest.matchers.shouldBe
import no.nav.lydia.sykefraversstatistikk.import.*
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto.Companion.tilBehandletLandSykefraværsstatistikk
import kotlin.test.Test

class SykefraversstatistikkPerKategoriImportDtoTest {

    @Test
    fun `Mapper statistikk per kategori LAND til behandlet statistikk`() {
        val gjeldendeKvartal = Kvartal(2023, 1)
        val statistikk =
            SykefraversstatistikkPerKategoriImportDto(
                kategori = Kategori.LAND,
                kode = "NO",
                sistePubliserteKvartal = SistePubliserteKvartal(
                    årstall = gjeldendeKvartal.årstall,
                    kvartal = gjeldendeKvartal.kvartal,
                    prosent = 2.5,
                    tapteDagsverk = 2500.0,
                    muligeDagsverk = 10000.0,
                    antallPersoner = 10,
                    erMaskert = false
                ),
                siste4Kvartal = Siste4Kvartal(
                    prosent = 5.0,
                    tapteDagsverk = 50000.0,
                    muligeDagsverk = 100000.0,
                    erMaskert = false,
                    kvartaler = listOf(gjeldendeKvartal)
                )
            )

        val result = listOf(statistikk).tilBehandletLandSykefraværsstatistikk().first()

        result.kategori shouldBe Kategori.LAND.name
        result.land shouldBe "NO"
        result.årstall shouldBe gjeldendeKvartal.årstall
        result.kvartal shouldBe gjeldendeKvartal.kvartal
        result.maskert shouldBe false
        result.antallPersoner shouldBe 10
        result.muligeDagsverk shouldBe 10000.0
        result.tapteDagsverk shouldBe 2500.0
    }

    @Test
    fun `Behandlet statistikk maskerer sykefraværsprosent dersom antall personer er mindre enn 5`() {
        val gjeldendeKvartal = Kvartal(2023, 1)
        val statistikk =
            SykefraversstatistikkPerKategoriImportDto(
                kategori = Kategori.LAND,
                kode = "NO",
                sistePubliserteKvartal = SistePubliserteKvartal(
                    årstall = gjeldendeKvartal.årstall,
                    kvartal = gjeldendeKvartal.kvartal,
                    prosent = 2.5,
                    tapteDagsverk = 2500.0,
                    muligeDagsverk = 10000.0,
                    antallPersoner = 4,
                    erMaskert = false
                ),
                siste4Kvartal = Siste4Kvartal(
                    prosent = 5.0,
                    tapteDagsverk = 50000.0,
                    muligeDagsverk = 100000.0,
                    erMaskert = false,
                    kvartaler = listOf(gjeldendeKvartal)
                )
            )

        val result = listOf(statistikk).tilBehandletLandSykefraværsstatistikk().first()

        result.prosent shouldBe 0.0
        result.maskert shouldBe true
        result.antallPersoner shouldBe 4
        result.muligeDagsverk shouldBe 0.0
        result.tapteDagsverk shouldBe 0.0
    }
}
