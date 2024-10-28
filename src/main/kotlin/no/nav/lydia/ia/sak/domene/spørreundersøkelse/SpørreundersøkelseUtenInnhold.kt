package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus
import java.time.LocalDateTime
import java.util.UUID

data class SpørreundersøkelseUtenInnhold(
    val kartleggingId: UUID,
    val prosessId: Int,
    val status: SpørreundersøkelseStatus,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
)
