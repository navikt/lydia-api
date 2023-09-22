package no.nav.lydia.sykefraversstatistikk.domene

import kotlinx.datetime.LocalDate
import no.nav.lydia.ia.sak.domene.IAProsessStatus

data class Virksomhetsoversikt(
    val virksomhetsnavn: String,
    val orgnr: String,
    val arstall: Int,
    val kvartal: Int,
    val antallPersoner: Double,
    val tapteDagsverk: Double,
    val muligeDagsverk: Double,
    val sykefraversprosent: Double,
    val maskert: Boolean,
    val status: IAProsessStatus?,
    val eidAv: String?,
    val sistEndret: LocalDate?
)

