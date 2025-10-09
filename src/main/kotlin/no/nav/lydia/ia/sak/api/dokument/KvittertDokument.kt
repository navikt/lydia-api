package no.nav.lydia.ia.sak.api.dokument

import kotlinx.datetime.LocalDateTime
import java.util.UUID

data class KvittertDokument(
    val dokumentId: UUID,
    val samarbeidId: Int,
    val referanseId: UUID,
    val type: DokumentPubliseringDto.Type,
    val status: DokumentPubliseringDto.Status,
    val publisertTidspunkt: LocalDateTime?,
    val journalpostId: String?,
    val kvittertTidspunkt: LocalDateTime,
)
