package no.nav.lydia.sykefraversstatistikk.import

sealed class BehandletKvartalsvisSykefraværsstatistikk(
    open val statistikk: KvartalsvisSykefraværsstatistikk
) {
    val kvartal
        get() = statistikk.kvartal
    val årstall
        get() = statistikk.årstall
    val antallPersoner
        get() = statistikk.antallPersoner
    val maskert
        get() = statistikk.skalMaskeres()
    val prosent
        get() = if (statistikk.skalMaskeres()) 0.0 else statistikk.prosent
    val muligeDagsverk
        get() = if (statistikk.skalMaskeres()) 0.0 else statistikk.muligeDagsverk
    val tapteDagsverk
        get() = if (statistikk.skalMaskeres()) 0.0 else statistikk.tapteDagsverk
    val kategori
        get() = statistikk.kategori

    private fun KvartalsvisSykefraværsstatistikk.skalMaskeres() =
        maskert || antallPersoner < MIN_ANTALL_PERS_FOR_AT_STATISTIKKEN_IKKE_ER_PERSONOPPLYSNINGER

    companion object {
        val MIN_ANTALL_PERS_FOR_AT_STATISTIKKEN_IKKE_ER_PERSONOPPLYSNINGER = 5
    }
}

class BehandletLandSykefraværsstatistikk(
    override val statistikk: LandSykefravær
) : BehandletKvartalsvisSykefraværsstatistikk(statistikk) {
    val land
        get() = statistikk.kode
}

class BehandletNæringSykefraværsstatistikk(
    override val statistikk: NæringSykefravær
) : BehandletKvartalsvisSykefraværsstatistikk(statistikk) {
    val næring
        get() = statistikk.kode
}

class BehandletNæringsundergruppeSykefraværsstatistikk(
    override val statistikk: NæringsundergruppeSykefravær
) : BehandletKvartalsvisSykefraværsstatistikk(statistikk) {
    val næringsundergruppe
        get() = statistikk.kode
}

class BehandletSektorSykefraværsstatistikk(
    override val statistikk: SektorSykefravær
) : BehandletKvartalsvisSykefraværsstatistikk(statistikk) {
    val sektor
        get() = statistikk.kode
}

class BehandletVirksomhetSykefraværsstatistikk(
    override val statistikk: SykefraværsstatistikkForVirksomhet
) : BehandletKvartalsvisSykefraværsstatistikk(statistikk) {
    val orgnr
        get() = statistikk.orgnr
}

