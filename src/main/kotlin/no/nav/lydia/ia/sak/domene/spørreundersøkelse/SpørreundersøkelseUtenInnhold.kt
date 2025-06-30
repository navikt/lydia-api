package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import java.time.LocalDateTime
import java.util.UUID

data class SpørreundersøkelseUtenInnhold(
    val id: UUID,
    val samarbeidId: Int,
    val status: Spørreundersøkelse.Status,
    val publiseringStatus: DokumentPublisering.Status,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val gyldigTilTidspunkt: LocalDateTime,
)
