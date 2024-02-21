package no.nav.lydia.ia.sak.domene

import java.time.LocalDateTime
import java.util.UUID

data class IASakKartleggingOversikt(
    val kartleggingId: UUID,
    val vertId: UUID?,
    val saksnummer: String,
    val status: KartleggingStatus,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?
)