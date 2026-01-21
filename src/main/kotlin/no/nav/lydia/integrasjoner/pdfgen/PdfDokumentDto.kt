package no.nav.fia.dokument.publisering.pdfgen

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonObject
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringSakDto
import no.nav.lydia.ia.sak.api.dokument.SamarbeidDto
import no.nav.lydia.ia.sak.api.dokument.VirksomhetDto

@Serializable
data class PdfDokumentDto(
    val type: PdfType,
    val referanseId: String,
    val publiseringsdato: LocalDateTime,
    val virksomhet: VirksomhetDto,
    val sak: DokumentPubliseringSakDto,
    val samarbeid: SamarbeidDto,
    val innhold: JsonObject,
)
