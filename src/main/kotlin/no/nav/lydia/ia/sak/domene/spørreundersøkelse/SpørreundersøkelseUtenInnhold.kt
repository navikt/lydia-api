package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import java.time.LocalDateTime
import java.util.UUID

data class SpørreundersøkelseUtenInnhold(
    val id: UUID,
    val samarbeidId: Int,
    val status: Spørreundersøkelse.Status,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val gyldigTilTidspunkt: LocalDateTime,
)
