package no.nav.lydia.abc.kartlegging

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.abc.dokument.DokumentPubliseringDto
import no.nav.lydia.abc.dokument.PubliseringStatus

@Serializable
data class SpørreundersøkelseDto(
    val id: String,
    val samarbeidId: Int,
    val status: Spørreundersøkelse.Status,
    val temaer: List<TemaDto>,
    val opprettetAv: String,
    val type: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val publisertTidspunkt: LocalDateTime?,
    val publiseringStatus: DokumentPubliseringDto.Status,
    val gyldigTilTidspunkt: LocalDateTime,
)

fun Spørreundersøkelse.tilDto(publiseringStatus: PubliseringStatus): SpørreundersøkelseDto =
    SpørreundersøkelseDto(
        id = id.toString(),
        samarbeidId = samarbeidId,
        status = status,
        temaer = temaer.map { it.tilDto() },
        opprettetAv = opprettetAv,
        type = type.name.uppercase(),
        opprettetTidspunkt = opprettetTidspunkt,
        endretTidspunkt = endretTidspunkt,
        påbegyntTidspunkt = påbegyntTidspunkt,
        fullførtTidspunkt = fullførtTidspunkt,
        publisertTidspunkt = publiseringStatus.publiseringTidspunkt,
        publiseringStatus = publiseringStatus.status,
        gyldigTilTidspunkt = gyldigTilTidspunkt,
    )
