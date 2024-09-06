package no.nav.lydia.ia.sak.api.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseUtenInnhold

@Serializable
data class SpørreundersøkelseUtenInnholdDto(
    val kartleggingId: String,
    val prosessId: Int,
    val vertId: String,
    val status: SpørreundersøkelseStatus,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
)

fun List<SpørreundersøkelseUtenInnhold>.tilDto() = map { it.tilDto() }

fun SpørreundersøkelseUtenInnhold.tilDto() =
    SpørreundersøkelseUtenInnholdDto(
        kartleggingId = kartleggingId.toString(),
        prosessId = prosessId,
        vertId = vertId?.toString() ?: "",
        status = status,
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt.toKotlinLocalDateTime(),
        endretTidspunkt = endretTidspunkt?.toKotlinLocalDateTime(),
    )
