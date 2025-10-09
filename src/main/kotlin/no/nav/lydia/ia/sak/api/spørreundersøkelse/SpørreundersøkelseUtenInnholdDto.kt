package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto
import no.nav.lydia.ia.sak.api.dokument.PubliseringStatus
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

@Serializable
data class SpørreundersøkelseUtenInnholdDto(
    val id: String,
    val samarbeidId: Int,
    val status: Spørreundersøkelse.Status,
    val opprettetAv: String,
    val type: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val publiseringStatus: DokumentPubliseringDto.Status,
    val publisertTidspunkt: LocalDateTime?,
    val gyldigTilTidspunkt: LocalDateTime,
    val harMinstEttResultat: Boolean,
)

fun Spørreundersøkelse.tilUtenInnholdDto(publiseringStatus: PubliseringStatus?): SpørreundersøkelseUtenInnholdDto =
    SpørreundersøkelseUtenInnholdDto(
        id = id.toString(),
        samarbeidId = samarbeidId,
        status = status,
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt,
        endretTidspunkt = endretTidspunkt,
        påbegyntTidspunkt = påbegyntTidspunkt,
        fullførtTidspunkt = fullførtTidspunkt,
        gyldigTilTidspunkt = gyldigTilTidspunkt,
        publiseringStatus = publiseringStatus?.status ?: DokumentPubliseringDto.Status.IKKE_PUBLISERT,
        publisertTidspunkt = publiseringStatus?.publiseringTidspunkt,
        harMinstEttResultat = harMinstEttResultat(),
        type = type.name.uppercase(),
    )
