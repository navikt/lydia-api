package no.nav.lydia.sykefraversstatistikk.import

import com.google.gson.annotations.SerializedName
import kotlinx.serialization.Serializable

// OBS: Statistisk sentralbyrå (SSB) og Brønnøysundregistret bruker SN2007 standard for næringskoder
// (dvs kode som 'viser virksomhets hovedaktivitet').
// ref: https://www.brreg.no/bedrift/naeringskoder/
// Vi importerer statistikk på to forskjellige nivåer av SN2007 næringsgruppering:
//  - Næring: det andre nivået i SN2007 identifisert ved en tosifret tallkode
//  - Næringskode: femte nivå identifisert ved en femsifret tallkode (kalt også - feilaktig - 'bransje')
enum class Kategori {
    VIRKSOMHET, LAND, SEKTOR, BRANSJE, NÆRING, NÆRINGSKODE;

    fun tabellnavn() = when (this) {
        LAND -> "sykefravar_statistikk_land"
        SEKTOR -> "sykefravar_statistikk_sektor"
        BRANSJE -> "sykefravar_statistikk_bransje"
        NÆRING -> "sykefravar_statistikk_naring"
        NÆRINGSKODE -> "sykefravar_statistikk_naringsundergruppe"
        VIRKSOMHET -> "sykefravar_statistikk_virksomhet"
    }

    fun kodenavn() = when (this) {
        LAND -> "land"
        SEKTOR -> "sektor_kode"
        BRANSJE -> "bransje"
        NÆRING -> "naring"
        NÆRINGSKODE -> "naringsundergruppe"
        VIRKSOMHET -> "orgnr"
    }
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

        private fun SykefraversstatistikkPerKategoriImportDto.tilBehandletBransjeSykefraværsstatistikk() =
            BehandletBransjeSykefraværsstatistikk(
                statistikk = BransjeSykefravær(
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

        private fun SykefraversstatistikkPerKategoriImportDto.tilBehandletNæringSykefraværsstatistikk() =
            BehandletNæringSykefraværsstatistikk(
                statistikk = NæringSykefravær(
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

        private fun SykefraversstatistikkPerKategoriImportDto.tilBehandletNæringsundergruppeSykefraværsstatistikk() =
            BehandletNæringsundergruppeSykefraværsstatistikk(
                statistikk = NæringsundergruppeSykefravær(
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

        private fun SykefraversstatistikkPerKategoriImportDto.tilBehandletVirksomhetSykefraværsstatistikk() =
            BehandletVirksomhetSykefraværsstatistikk(
                statistikk = SykefraværsstatistikkForVirksomhet(
                    årstall = this.sistePubliserteKvartal.årstall,
                    kvartal = this.sistePubliserteKvartal.kvartal,
                    prosent = this.sistePubliserteKvartal.prosent ?: 0.0,
                    muligeDagsverk = this.sistePubliserteKvartal.muligeDagsverk ?: 0.0,
                    antallPersoner = this.sistePubliserteKvartal.antallPersoner?.toDouble() ?: 0.0,
                    tapteDagsverk = this.sistePubliserteKvartal.tapteDagsverk ?: 0.0,
                    maskert = this.sistePubliserteKvartal.erMaskert,
                    kategori = this.kategori.name,
                    orgnr = this.kode
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

        fun List<SykefraversstatistikkPerKategoriImportDto>.tilBehandletBransjeSykefraværsstatistikk() =
            this.map {
                it.tilBehandletBransjeSykefraværsstatistikk()
            }

        fun List<SykefraversstatistikkPerKategoriImportDto>.tilBehandletNæringSykefraværsstatistikk() =
            this.map {
                it.tilBehandletNæringSykefraværsstatistikk()
            }

        fun List<SykefraversstatistikkPerKategoriImportDto>.tilBehandletNæringsundergruppeSykefraværsstatistikk() =
            this.map {
                it.tilBehandletNæringsundergruppeSykefraværsstatistikk()
            }

        fun List<SykefraversstatistikkPerKategoriImportDto>.tilBehandletVirksomhetSykefraværsstatistikk() =
            this.map {
                it.tilBehandletVirksomhetSykefraværsstatistikk()
            }
    }
}

@Serializable
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

@Serializable
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
