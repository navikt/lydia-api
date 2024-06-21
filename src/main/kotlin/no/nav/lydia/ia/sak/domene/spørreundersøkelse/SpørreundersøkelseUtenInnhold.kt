package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import java.time.LocalDateTime
import java.util.UUID

data class SpørreundersøkelseUtenInnhold(
    val kartleggingId: UUID,
    val vertId: UUID?,
    val status: KartleggingStatus,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
)