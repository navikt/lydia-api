package no.nav.lydia.arbeidsgiver

import kotlinx.datetime.LocalDateTime
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.integrasjoner.pdfgen.SamarbeidDto

data class SamarbeidMedDokumenterDto(
    val id: Int,
    val saksnummer: String,
    val navn: String,
    val status: IASamarbeid.Status? = null,
    val opprettet: LocalDateTime? = null,
    val sistEndret: LocalDateTime? = null,
    val dokumenter: List<String> = emptyList(),
)
