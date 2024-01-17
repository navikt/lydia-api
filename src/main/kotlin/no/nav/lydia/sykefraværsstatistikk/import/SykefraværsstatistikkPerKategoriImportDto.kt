package no.nav.lydia.sykefraværsstatistikk.import

import com.google.gson.annotations.SerializedName
import kotlinx.serialization.Serializable
import no.nav.lydia.virksomhet.domene.erGyldigSektor
import no.nav.lydia.virksomhet.domene.tilSektor
import java.lang.IllegalArgumentException

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

data class SykefraværsstatistikkPerKategoriImportDto(
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
        private fun SykefraværsstatistikkPerKategoriImportDto.tilBehandletLandSykefraværsstatistikk() =
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

        private fun SykefraværsstatistikkPerKategoriImportDto.tilBehandletSektorSykefraværsstatistikk() =
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
                    kode = this.kode.tilSektor()?.kode ?: throw IllegalArgumentException("Ukjent sektor"), // Dette skal aldri skje, DTO er allerede filtrert
                )
            )

        private fun SykefraværsstatistikkPerKategoriImportDto.tilBehandletBransjeSykefraværsstatistikk() =
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

        private fun SykefraværsstatistikkPerKategoriImportDto.tilBehandletNæringSykefraværsstatistikk() =
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

        private fun SykefraværsstatistikkPerKategoriImportDto.tilBehandletNæringsundergruppeSykefraværsstatistikk() =
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

        private fun SykefraværsstatistikkPerKategoriImportDto.tilBehandletVirksomhetSykefraværsstatistikk() =
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

        private fun SykefraværsstatistikkPerKategoriImportDto.tilBehandletVirksomhetSykefraværsstatistikkSiste4Kvartal() =
            BehandletVirksomhetSykefraværsstatistikkSiste4Kvartal(
                statistikk = SykefraværsstatistikkForVirksomhetSiste4Kvartal(
                    publisertÅrstall = this.sistePubliserteKvartal.årstall,
                    publisertKvartal = this.sistePubliserteKvartal.kvartal,
                    prosent = this.siste4Kvartal.prosent ?: 0.0,
                    muligeDagsverk = this.siste4Kvartal.muligeDagsverk ?: 0.0,
                    tapteDagsverk = this.siste4Kvartal.tapteDagsverk ?: 0.0,
                    maskert = this.siste4Kvartal.erMaskert,
                    kvartaler = this.siste4Kvartal.kvartaler,
                    kategori = this.kategori.name,
                    orgnr = this.kode
                )
            )

        // Vi får Sektor fra Sykefraværsstatistikk-api som en 'beskrivelse' men lagre statistikk på tilsvarende 'kode'
        fun List<SykefraværsstatistikkPerKategoriImportDto>.mapSektorNavnTilSektorKode() =
            this.map {
                when (it.kategori) {
                    Kategori.SEKTOR -> SykefraværsstatistikkPerKategoriImportDto(
                        kategori = it.kategori,
                        kode = it.kode.tilSektor()?.kode
                            ?: throw IllegalArgumentException("Ukjent sektor"), // Dette skal aldri skje, DTO er allerede filtrert
                        sistePubliserteKvartal = it.sistePubliserteKvartal,
                        siste4Kvartal = it.siste4Kvartal
                    )
                    else -> it
                }
            }

        fun List<SykefraværsstatistikkPerKategoriImportDto>.filterPåKategoriSektorOgGyldigSektor() =
            this.filter { it.kategori == Kategori.SEKTOR && it.kode.erGyldigSektor() }

        fun List<SykefraværsstatistikkPerKategoriImportDto>.tilBehandletLandSykefraværsstatistikk() =
            this.map {
                it.tilBehandletLandSykefraværsstatistikk()
            }

        fun List<SykefraværsstatistikkPerKategoriImportDto>.tilBehandletSektorSykefraværsstatistikk() =
            this.filterPåKategoriSektorOgGyldigSektor()
                .map {
                    it.tilBehandletSektorSykefraværsstatistikk()
                }

        fun List<SykefraværsstatistikkPerKategoriImportDto>.tilBehandletBransjeSykefraværsstatistikk() =
            this.map {
                it.tilBehandletBransjeSykefraværsstatistikk()
            }

        fun List<SykefraværsstatistikkPerKategoriImportDto>.tilBehandletNæringSykefraværsstatistikk() =
            this.map {
                it.tilBehandletNæringSykefraværsstatistikk()
            }

        fun List<SykefraværsstatistikkPerKategoriImportDto>.tilBehandletNæringsundergruppeSykefraværsstatistikk() =
            this.map {
                it.tilBehandletNæringsundergruppeSykefraværsstatistikk()
            }

        fun List<SykefraværsstatistikkPerKategoriImportDto>.tilBehandletVirksomhetSykefraværsstatistikk() =
            this.map {
                it.tilBehandletVirksomhetSykefraværsstatistikk()
            }

        fun List<SykefraværsstatistikkPerKategoriImportDto>.tilBehandletVirksomhetSykefraværsstatistikkSiste4Kvartal() =
            this.map {
                it.tilBehandletVirksomhetSykefraværsstatistikkSiste4Kvartal()
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

data class KeySykefraværsstatistikkPerKategori(
    val kategori: String,
    val kode: String,
    val kvartal: Int,
    val årstall: Int,
)
