package no.nav.lydia.integrasjoner.pdfgen

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonObject
import no.nav.fia.dokument.publisering.pdfgen.PdfType
import no.nav.lydia.dokumentpublisering.DokumentPubliseringSakDto
import no.nav.lydia.dokumentpublisering.SamarbeidDto
import no.nav.lydia.dokumentpublisering.VirksomhetDto

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
