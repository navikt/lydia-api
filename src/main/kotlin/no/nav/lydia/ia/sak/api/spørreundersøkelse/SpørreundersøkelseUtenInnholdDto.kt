package no.nav.lydia.ia.sak.api.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseUtenInnhold

@Serializable
data class SpørreundersøkelseUtenInnholdDto(
    val id: String,
    @Deprecated("Bruk Id i stedet")
    val kartleggingId: String,
    val samarbeidId: Int,
    @Deprecated("Bruk Id i stedet")
    val prosessId: Int,
    val status: SpørreundersøkelseStatus,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
)

fun List<SpørreundersøkelseUtenInnhold>.tilDto() = map { it.tilDto() }

fun SpørreundersøkelseUtenInnhold.tilDto() =
    SpørreundersøkelseUtenInnholdDto(
        kartleggingId = id.toString(),
        id = id.toString(),
        prosessId = samarbeidId,
        samarbeidId = samarbeidId,
        status = status,
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt.toKotlinLocalDateTime(),
        endretTidspunkt = endretTidspunkt?.toKotlinLocalDateTime(),
    )
