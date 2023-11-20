package no.nav.lydia.sykefraværsstatistikk.domene

import kotlinx.serialization.Serializable

@Serializable
data class VirksomhetsstatistikkSisteKvartal(
    val orgnr: String,
    val arstall: Int,
    val kvartal: Int,
    val antallPersoner: Double,
    val tapteDagsverkGradert: Double?,
    val tapteDagsverk: Double,
    val muligeDagsverk: Double,
    val sykefraversprosent: Double,
    val graderingsprosent: Double?,
    val maskert: Boolean,
)
