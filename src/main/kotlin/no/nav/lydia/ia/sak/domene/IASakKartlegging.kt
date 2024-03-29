package no.nav.lydia.ia.sak.domene

import no.nav.lydia.integrasjoner.kartlegging.KartleggingRepository
import java.time.LocalDateTime
import java.util.UUID

data class IASakKartlegging(
    val kartleggingId: UUID,
    val vertId: UUID?,
    val saksnummer: String,
    val status: KartleggingStatus,
    val temaMedSpørsmålOgSvaralternativer: List<TemaMedSpørsmålOgSvaralternativer>,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?
)