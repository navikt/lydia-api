package no.nav.lydia.sykefraværsstatistikk.import

sealed class KvartalsvisSykefraværsstatistikk {
    abstract val kvartal: Int
    abstract val årstall: Int
    abstract val prosent: Double
    abstract val muligeDagsverk: Double
    abstract val antallPersoner: Double
    abstract val tapteDagsverk: Double
    abstract val maskert: Boolean
    abstract val kategori: String
}

sealed class AggregertSykefraværsstatistikk : KvartalsvisSykefraværsstatistikk() {
    abstract val kode: String
}

data class BransjeSykefravær(
    override val kvartal: Int,
    override val årstall: Int,
    override val prosent: Double,
    override val muligeDagsverk: Double,
    override val antallPersoner: Double,
    override val tapteDagsverk: Double,
    override val maskert: Boolean,
    override val kategori: String,
    override val kode: String,
): AggregertSykefraværsstatistikk()

data class NæringSykefravær(
    override val kvartal: Int,
    override val årstall: Int,
    override val prosent: Double,
    override val muligeDagsverk: Double,
    override val antallPersoner: Double,
    override val tapteDagsverk: Double,
    override val maskert: Boolean,
    override val kategori: String,
    override val kode: String,
) : AggregertSykefraværsstatistikk()

data class NæringsundergruppeSykefravær(
    override val kvartal: Int,
    override val årstall: Int,
    override val prosent: Double,
    override val muligeDagsverk: Double,
    override val antallPersoner: Double,
    override val tapteDagsverk: Double,
    override val maskert: Boolean,
    override val kategori: String,
    override val kode: String,
) : AggregertSykefraværsstatistikk()

data class SektorSykefravær(
    override val kvartal: Int,
    override val årstall: Int,
    override val prosent: Double,
    override val muligeDagsverk: Double,
    override val antallPersoner: Double,
    override val tapteDagsverk: Double,
    override val maskert: Boolean,
    override val kategori: String,
    override val kode: String,
) : AggregertSykefraværsstatistikk()

data class LandSykefravær(
    override val kvartal: Int,
    override val årstall: Int,
    override val prosent: Double,
    override val muligeDagsverk: Double,
    override val antallPersoner: Double,
    override val tapteDagsverk: Double,
    override val maskert: Boolean,
    override val kategori: String,
    override val kode: String,
) : AggregertSykefraværsstatistikk()

data class SykefraværsstatistikkForVirksomhet(
    override val kvartal: Int,
    override val årstall: Int,
    override val prosent: Double,
    override val muligeDagsverk: Double,
    override val antallPersoner: Double,
    override val tapteDagsverk: Double,
    override val maskert: Boolean,
    override val kategori: String,
    val orgnr: String,
) : KvartalsvisSykefraværsstatistikk()
