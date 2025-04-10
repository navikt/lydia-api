package no.nav.lydia.ia.sak.api.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

@Serializable
data class SpørreundersøkelseDto(
    val id: String,
    @Deprecated("Bruk id")
    val kartleggingId: String,
    val samarbeidId: Int,
    @Deprecated("Bruk samarbeidId")
    val prosessId: Int,
    val status: SpørreundersøkelseStatus,
    val temaer: List<TemaDto>,
    @Deprecated("Bruk temaer")
    val temaMedSpørsmålOgSvaralternativer: List<TemaDto>,
    val opprettetAv: String,
    val type: Spørreundersøkelse.Companion.Type,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val gyldigTilTidspunkt: LocalDateTime,
)

fun Spørreundersøkelse.tilDto() =
    SpørreundersøkelseDto(
        id = id.toString(),
        kartleggingId = id.toString(),
        samarbeidId = samarbeidId,
        prosessId = samarbeidId,
        status = status,
        temaer = temaer.map { it.toDto() },
        temaMedSpørsmålOgSvaralternativer = temaer.map { it.toDto() },
        opprettetAv = opprettetAv,
        type = type,
        opprettetTidspunkt = opprettetTidspunkt,
        endretTidspunkt = endretTidspunkt,
        påbegyntTidspunkt = påbegyntTidspunkt,
        fullførtTidspunkt = fullførtTidspunkt,
        gyldigTilTidspunkt = gyldigTilTidspunkt,
    )
