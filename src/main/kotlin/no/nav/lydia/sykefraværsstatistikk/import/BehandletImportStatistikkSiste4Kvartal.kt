package no.nav.lydia.sykefraværsstatistikk.import

sealed class BehandletSykefraværsstatistikkSiste4Kvartal(
    open val statistikk: SykefraværsstatistikkSiste4Kvartal,
) {
    val publisertKvartal
        get() = statistikk.publisertKvartal
    val publisertÅrstall
        get() = statistikk.publisertÅrstall
    val maskert
        get() = statistikk.maskert // her stoler vi på at `maskert` er riktig siden vi ikke har antallPersoner for siste4kvartal
    val prosent
        get() = if (statistikk.maskert) 0.0 else statistikk.prosent
    val muligeDagsverk
        get() = if (statistikk.maskert) 0.0 else statistikk.muligeDagsverk
    val tapteDagsverk
        get() = if (statistikk.maskert) 0.0 else statistikk.tapteDagsverk
    val kvartaler
        get() = statistikk.kvartaler
    val kategori
        get() = statistikk.kategori
}

class BehandletVirksomhetSykefraværsstatistikkSiste4Kvartal(
    override val statistikk: SykefraværsstatistikkForVirksomhetSiste4Kvartal,
) : BehandletSykefraværsstatistikkSiste4Kvartal(statistikk) {
    val orgnr
        get() = statistikk.orgnr
}
