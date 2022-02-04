package no.nav.lydia.sykefraversstatistikk.domene

import java.time.LocalDateTime

class SykefraversstatistikkVirksomhet(
    val id: String,
    val orgnr: String,
    val arstall: Int,
    val kvartal: Int,
    val antallPersoner: Double,
    val tapteDagsverk: Double,
    val muligeDagsverk: Double,
    val sykefraversprosent: Double,
    val maskert: Boolean,
    val opprettet: LocalDateTime
)