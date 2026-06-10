package no.nav.lydia.abc.dokumentpublisering

import kotlinx.datetime.LocalDateTime
import java.util.UUID

data class PubliseringStatus(
    val referanseId: UUID,
    val type: DokumentPubliseringDto.Type,
    val status: DokumentPubliseringDto.Status,
    val publiseringTidspunkt: LocalDateTime?,
)
