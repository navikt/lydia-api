package no.nav.lydia.sykefraversstatistikk.import

class SykefraversstatistikkImportDto(
    val orgnr: String,
    val arstall: Int,
    val kvartal: Int,
    val antallPersoner: Double,
    val tapteDagsverk: Double,
    val muligeDagsverk: Double,
    val sykefraversprosent: Double,
    val maskert: Boolean,
)