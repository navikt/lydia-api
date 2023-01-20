package no.nav.lydia.sykefraversstatistikk.domene

import kotlinx.serialization.Serializable

@Serializable
data class VirksomhetsstatistikkSisteKvartal(
    val orgnr: String,
    val arstall: Int,
    val kvartal: Int,
    val antallPersoner: Double,
    val tapteDagsverk: Double,
    val muligeDagsverk: Double,
    val sykefraversprosent: Double,
    val maskert: Boolean,
)
