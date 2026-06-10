package no.nav.lydia.prioritering.sykefraværsstatistikk.domene

import no.nav.lydia.prioritering.sykefraværsstatistikk.import.Kvartal
import java.time.LocalDateTime

data class VirksomhetsstatistikkSiste4Kvartal(
    val orgnr: String,
    val tapteDagsverk: Double,
    val tapteDagsverkGradert: Double?,
    val muligeDagsverk: Double,
    val sykefraværsprosent: Double,
    val graderingsprosent: Double?,
    val maskert: Boolean,
    val opprettet: LocalDateTime,
    val antallKvartaler: Int,
    val kvartaler: List<Kvartal>,
)
