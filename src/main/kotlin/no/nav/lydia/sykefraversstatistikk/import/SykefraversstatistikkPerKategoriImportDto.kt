package no.nav.lydia.sykefraversstatistikk.import

import com.google.gson.annotations.SerializedName
import kotlinx.serialization.Serializable

enum class Kategori {
    VIRKSOMHET, LAND, SEKTOR
}

data class SykefraversstatistikkPerKategoriImportDto(
    @SerializedName("kategori")
    val kategori: Kategori,
    @SerializedName("kode")
    val kode: String,
    @SerializedName("sistePubliserteKvartal")
    val sistePubliserteKvartal: SistePubliserteKvartal,
    @SerializedName("siste4Kvartal")
    val siste4Kvartal: Siste4Kvartal,
) {
    companion object {
        private fun SykefraversstatistikkPerKategoriImportDto.tilBehandletLandSykefraværsstatistikk() =
            BehandletLandSykefraværsstatistikk(
                statistikk = LandSykefravær(
                    årstall = this.sistePubliserteKvartal.årstall,
                    kvartal = this.sistePubliserteKvartal.kvartal,
                    prosent = this.sistePubliserteKvartal.prosent ?: 0.0,
                    muligeDagsverk = this.sistePubliserteKvartal.muligeDagsverk ?: 0.0,
                    antallPersoner = this.sistePubliserteKvartal.antallPersoner?.toDouble() ?: 0.0,
                    tapteDagsverk = this.sistePubliserteKvartal.tapteDagsverk ?: 0.0,
                    maskert = this.sistePubliserteKvartal.erMaskert,
                    kategori = this.kategori.name,
                    kode = this.kode,
                )
            )
        private fun SykefraversstatistikkPerKategoriImportDto.tilBehandletSektorSykefraværsstatistikk() =
            BehandletSektorSykefraværsstatistikk(
                statistikk = SektorSykefravær(
                    årstall = this.sistePubliserteKvartal.årstall,
                    kvartal = this.sistePubliserteKvartal.kvartal,
                    prosent = this.sistePubliserteKvartal.prosent ?: 0.0,
                    muligeDagsverk = this.sistePubliserteKvartal.muligeDagsverk ?: 0.0,
                    antallPersoner = this.sistePubliserteKvartal.antallPersoner?.toDouble() ?: 0.0,
                    tapteDagsverk = this.sistePubliserteKvartal.tapteDagsverk ?: 0.0,
                    maskert = this.sistePubliserteKvartal.erMaskert,
                    kategori = this.kategori.name,
                    kode = this.kode,
                )
            )

        fun List<SykefraversstatistikkPerKategoriImportDto>.tilBehandletLandSykefraværsstatistikk() =
            this.map {
                it.tilBehandletLandSykefraværsstatistikk()
            }

        fun List<SykefraversstatistikkPerKategoriImportDto>.tilBehandletSektorSykefraværsstatistikk() =
            this.map {
                it.tilBehandletSektorSykefraværsstatistikk()
            }
    }
}

data class Siste4Kvartal(
    @SerializedName("prosent")
    val prosent: Double?,
    @SerializedName("tapteDagsverk")
    val tapteDagsverk: Double?,
    @SerializedName("muligeDagsverk")
    val muligeDagsverk: Double?,
    @SerializedName("erMaskert")
    val erMaskert: Boolean,
    @SerializedName("kvartaler")
    val kvartaler: List<Kvartal>
)

@Serializable
data class Kvartal(
    @SerializedName("årstall")
    val årstall: Int,
    @SerializedName("kvartal")
    val kvartal: Int,
)

data class SistePubliserteKvartal(
    @SerializedName("årstall")
    val årstall: Int,
    @SerializedName("kvartal")
    val kvartal: Int,
    @SerializedName("prosent")
    val prosent: Double?,
    @SerializedName("tapteDagsverk")
    val tapteDagsverk: Double?,
    @SerializedName("muligeDagsverk")
    val muligeDagsverk: Double?,
    @SerializedName("antallPersoner")
    val antallPersoner: Int?,
    @SerializedName("erMaskert")
    val erMaskert: Boolean
)

data class KeySykefraversstatistikkPerKategori(
    val kategori: String,
    val kode: String,
    val kvartal: Int,
    val årstall: Int,
)
