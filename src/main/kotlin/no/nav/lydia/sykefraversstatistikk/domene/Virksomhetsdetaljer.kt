package no.nav.lydia.sykefraversstatistikk.domene

import kotlinx.datetime.LocalDate
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.sykefraversstatistikk.import.Kvartal
import java.time.LocalDateTime

data class Virksomhetsdetaljer(
    val virksomhetsnavn: String,
    val kommune: Kommune,
    val orgnr: String,
    val arstall: Int,
    val kvartal: Int,
    val antallPersoner: Double,
    val tapteDagsverk: Double,
    val muligeDagsverk: Double,
    val sykefraversprosent: Double,
    val maskert: Boolean,
    val opprettet: LocalDateTime,
    val status: IAProsessStatus?,
    val eidAv: String?,
    val sistEndret: LocalDate?,
    val antallKvartaler: Int,
    val kvartaler: List<Kvartal>,
)