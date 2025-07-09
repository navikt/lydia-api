package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

@Serializable
data class SpørreundersøkelseUtenInnholdDto(
    val id: String,
    val samarbeidId: Int,
    val status: Spørreundersøkelse.Status,
    val publiseringStatus: DokumentPublisering.Status,
    val opprettetAv: String,
    val type: Spørreundersøkelse.Type,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val gyldigTilTidspunkt: LocalDateTime,
    val harMinstEttResultat: Boolean,
)

fun List<Spørreundersøkelse>.tilMetaDto(): List<SpørreundersøkelseUtenInnholdDto> = map { it.tilMetaDto() }

fun Spørreundersøkelse.tilMetaDto(): SpørreundersøkelseUtenInnholdDto =
    SpørreundersøkelseUtenInnholdDto(
        id = id.toString(),
        samarbeidId = samarbeidId,
        status = status,
        publiseringStatus = publiseringStatus,
        opprettetAv = opprettetAv,
        type = type,
        opprettetTidspunkt = opprettetTidspunkt,
        endretTidspunkt = endretTidspunkt,
        påbegyntTidspunkt = påbegyntTidspunkt,
        fullførtTidspunkt = fullførtTidspunkt,
        gyldigTilTidspunkt = gyldigTilTidspunkt,
        harMinstEttResultat = harMinstEttResultat(),
    )
