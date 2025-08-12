package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Companion.harMinstEttResultat

@Serializable
data class SpørreundersøkelseUtenInnholdDto(
    val id: String,
    val samarbeidId: Int,
    val status: Spørreundersøkelse.Status,
    val publiseringStatus: DokumentPublisering.Status,
    val opprettetAv: String,
    val type: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val gyldigTilTidspunkt: LocalDateTime,
    val harMinstEttResultat: Boolean,
)

fun List<Spørreundersøkelse>.tilUtenInnholdDto(): List<SpørreundersøkelseUtenInnholdDto> = map { it.tilUtenInnholdDto() }

fun Spørreundersøkelse.tilUtenInnholdDto(): SpørreundersøkelseUtenInnholdDto =
    SpørreundersøkelseUtenInnholdDto(
        id = id.toString(),
        samarbeidId = samarbeidId,
        status = status,
        publiseringStatus = publiseringStatus,
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt,
        endretTidspunkt = endretTidspunkt,
        påbegyntTidspunkt = påbegyntTidspunkt,
        fullførtTidspunkt = fullførtTidspunkt,
        gyldigTilTidspunkt = gyldigTilTidspunkt,
        harMinstEttResultat = harMinstEttResultat(this),
        type = type.name.uppercase(),
    )
