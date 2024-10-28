package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus
import java.time.LocalDateTime
import java.util.UUID

data class SpørreundersøkelseUtenInnhold(
    val id: UUID,
    val samarbeidId: Int,
    val status: SpørreundersøkelseStatus,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
)
