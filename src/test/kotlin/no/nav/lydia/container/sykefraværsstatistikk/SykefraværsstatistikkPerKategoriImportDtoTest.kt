package no.nav.lydia.container.sykefraværsstatistikk

import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.TestData
import no.nav.lydia.sykefraværsstatistikk.import.*
import no.nav.lydia.sykefraværsstatistikk.import.SykefraværsstatistikkPerKategoriImportDto.Companion.tilBehandletLandSykefraværsstatistikk
import no.nav.lydia.sykefraværsstatistikk.import.SykefraværsstatistikkPerKategoriImportDto.Companion.tilBehandletVirksomhetSykefraværsstatistikk
import kotlin.test.Test

class SykefraværsstatistikkPerKategoriImportDtoTest {

    private val gjeldendePeriode = TestData.gjeldendePeriode

    @Test
    fun `Mapper statistikk per kategori LAND til behandlet statistikk`() {
        val result = listOf(statistikkDto(Kategori.LAND, "NO", 10))
            .tilBehandletLandSykefraværsstatistikk().first()

        result.kategori shouldBe Kategori.LAND.name
        result.land shouldBe "NO"
        result.årstall shouldBe gjeldendePeriode.årstall
        result.kvartal shouldBe gjeldendePeriode.kvartal
        result.prosent shouldBe 2.5
        result.maskert shouldBe false
        result.antallPersoner shouldBe 10
        result.muligeDagsverk shouldBe 10000.0
        result.tapteDagsverk shouldBe 2500.0
    }

    @Test
    fun `Mapper statistikk per kategori VIRKSOMHET til behandlet statistikk`() {
        val result = listOf(statistikkDto(Kategori.VIRKSOMHET, "999999999", 10))
            .tilBehandletVirksomhetSykefraværsstatistikk().first()

        result.kategori shouldBe Kategori.VIRKSOMHET.name
        result.orgnr shouldBe "999999999"
        result.årstall shouldBe gjeldendePeriode.årstall
        result.kvartal shouldBe gjeldendePeriode.kvartal
        result.prosent shouldBe 2.5
        result.maskert shouldBe false
        result.antallPersoner shouldBe 10
        result.muligeDagsverk shouldBe 10000.0
        result.tapteDagsverk shouldBe 2500.0
    }

    @Test
    fun `Behandlet statistikk maskerer sykefraværsprosent dersom antall personer er mindre enn 5`() {
        val result = listOf(statistikkDto(Kategori.VIRKSOMHET, "999999999", 4))
            .tilBehandletVirksomhetSykefraværsstatistikk().first()

        result.orgnr shouldBe "999999999"
        result.årstall shouldBe gjeldendePeriode.årstall
        result.kvartal shouldBe gjeldendePeriode.kvartal
        result.prosent shouldBe 0.0
        result.maskert shouldBe true
        result.antallPersoner shouldBe 4
        result.muligeDagsverk shouldBe 0.0
        result.tapteDagsverk shouldBe 0.0
    }


    private fun statistikkDto(kategori: Kategori, kode: String, antallPersoner: Int) =
        SykefraværsstatistikkPerKategoriImportDto(
            kategori = kategori,
            kode = kode,
            sistePubliserteKvartal = SistePubliserteKvartal(
                årstall = gjeldendePeriode.årstall,
                kvartal = gjeldendePeriode.kvartal,
                prosent = 2.5,
                tapteDagsverk = 2500.0,
                muligeDagsverk = 10000.0,
                antallPersoner = antallPersoner,
                erMaskert = false
            ),
            siste4Kvartal = Siste4Kvartal(
                prosent = 5.0,
                tapteDagsverk = 50000.0,
                muligeDagsverk = 100000.0,
                erMaskert = false,
                kvartaler = listOf(gjeldendePeriode.tilKvartal())
            )
        )
}
