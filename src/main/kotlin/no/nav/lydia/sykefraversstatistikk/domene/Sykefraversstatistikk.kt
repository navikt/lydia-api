package no.nav.lydia.sykefraversstatistikk.domene

import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import java.time.LocalDateTime

class SykefraversstatistikkVirksomhet(
    val virksomhetsnavn: String?,
    val kommune: Kommune?,
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