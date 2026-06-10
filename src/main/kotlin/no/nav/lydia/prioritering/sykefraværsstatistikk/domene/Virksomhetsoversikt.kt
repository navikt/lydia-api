package no.nav.lydia.prioritering.sykefraværsstatistikk.domene

import kotlinx.datetime.LocalDate
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand

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
    val tilstand: VirksomhetIATilstand?,
    val eidAv: String?,
    val sistEndret: LocalDate?,
)
