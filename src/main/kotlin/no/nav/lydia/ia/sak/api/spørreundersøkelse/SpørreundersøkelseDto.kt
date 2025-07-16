package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

@Serializable
data class SpørreundersøkelseDto(
    val id: String,
    val samarbeidId: Int,
    val status: Spørreundersøkelse.Status,
    val temaer: List<TemaDto>,
    val opprettetAv: String,
    val type: Spørreundersøkelse.Type,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val gyldigTilTidspunkt: LocalDateTime,
)

fun Spørreundersøkelse.tilDto(): SpørreundersøkelseDto =
    SpørreundersøkelseDto(
        id = id.toString(),
        samarbeidId = samarbeidId,
        status = status,
        temaer = temaer.map { it.tilDto() },
        opprettetAv = opprettetAv,
        type = type,
        opprettetTidspunkt = opprettetTidspunkt,
        endretTidspunkt = endretTidspunkt,
        påbegyntTidspunkt = påbegyntTidspunkt,
        fullførtTidspunkt = fullførtTidspunkt,
        gyldigTilTidspunkt = gyldigTilTidspunkt,
    )
