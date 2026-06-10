package no.nav.lydia.dokumentpublisering

import kotlinx.datetime.LocalDateTime
import java.util.UUID

data class PubliseringStatus(
    val referanseId: UUID,
    val type: DokumentPubliseringDto.Type,
    val status: DokumentPubliseringDto.Status,
    val publiseringTidspunkt: LocalDateTime?,
)
