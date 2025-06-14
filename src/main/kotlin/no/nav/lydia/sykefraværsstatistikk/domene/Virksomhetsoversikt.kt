package no.nav.lydia.sykefraværsstatistikk.domene

import kotlinx.datetime.LocalDate
import no.nav.lydia.ia.sak.domene.IASak

data class Virksomhetsoversikt(
    val virksomhetsnavn: String,
    val orgnr: String,
    val saksnummer: String?,
    val arstall: Int,
    val kvartal: Int,
    val antallPersoner: Double,
    val tapteDagsverk: Double,
    val muligeDagsverk: Double,
    val sykefraværsprosent: Double,
    val maskert: Boolean,
    val status: IASak.Status?,
    val eidAv: String?,
    val sistEndret: LocalDate?,
)
