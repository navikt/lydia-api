package no.nav.lydia.sykefraversstatistikk.domene

import no.nav.lydia.sykefraversstatistikk.import.Kvartal
import java.time.LocalDateTime

data class VirksomhetsstatistikkSiste4Kvartal(
    val orgnr: String,
    val tapteDagsverk: Double,
    val muligeDagsverk: Double,
    val sykefraversprosent: Double,
    val maskert: Boolean,
    val opprettet: LocalDateTime,
    val antallKvartaler: Int,
    val kvartaler: List<Kvartal>,
)
