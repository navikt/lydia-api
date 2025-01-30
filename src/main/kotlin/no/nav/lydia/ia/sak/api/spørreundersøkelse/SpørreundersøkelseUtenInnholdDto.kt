package no.nav.lydia.ia.sak.api.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseUtenInnhold

@Serializable
data class SpørreundersøkelseUtenInnholdDto(
    val id: String,
    val samarbeidId: Int,
    val status: SpørreundersøkelseStatus,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val gyldigTilTidspunkt: LocalDateTime,
)

fun List<SpørreundersøkelseUtenInnhold>.tilDto() = map { it.tilDto() }

fun SpørreundersøkelseUtenInnhold.tilDto() =
    SpørreundersøkelseUtenInnholdDto(
        id = id.toString(),
        samarbeidId = samarbeidId,
        status = status,
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt.toKotlinLocalDateTime(),
        endretTidspunkt = endretTidspunkt?.toKotlinLocalDateTime(),
        påbegyntTidspunkt = påbegyntTidspunkt?.toKotlinLocalDateTime(),
        fullførtTidspunkt = fullførtTidspunkt?.toKotlinLocalDateTime(),
        gyldigTilTidspunkt = gyldigTilTidspunkt.toKotlinLocalDateTime(),
    )
