package no.nav.lydia.ia.sak.api.dokument

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering.Status
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering.Type

@Serializable
data class DokumentPubliseringDto(
    val dokumentId: String,
    val referanseId: String,
    val opprettetAv: String,
    val status: Status,
    val dokumentType: Type,
    val opprettetTidspunkt: LocalDateTime,
    val publisertTidspunkt: LocalDateTime?,
)
