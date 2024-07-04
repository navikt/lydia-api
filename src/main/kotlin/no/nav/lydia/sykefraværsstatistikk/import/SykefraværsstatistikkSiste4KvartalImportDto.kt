package no.nav.lydia.sykefraværsstatistikk.import

sealed class SykefraværsstatistikkSiste4Kvartal {
    abstract val publisertKvartal: Int
    abstract val publisertÅrstall: Int
    abstract val kvartaler: List<Kvartal>

    abstract val prosent: Double
    abstract val muligeDagsverk: Double
    abstract val tapteDagsverk: Double
    abstract val maskert: Boolean
    abstract val kategori: String
}

data class SykefraværsstatistikkForVirksomhetSiste4Kvartal(
    override val publisertKvartal: Int,
    override val publisertÅrstall: Int,
    override val kvartaler: List<Kvartal>,

    override val prosent: Double,
    override val muligeDagsverk: Double,
    override val tapteDagsverk: Double,
    override val maskert: Boolean,
    override val kategori: String,
    val orgnr: String,
) : SykefraværsstatistikkSiste4Kvartal()
