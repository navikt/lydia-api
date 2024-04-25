package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseUtenInnhold
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.KartleggingStatus

@Serializable
data class SpørreundersøkelseUtenInnholdDto(
    val kartleggingId: String,
    val vertId: String,
    val status: KartleggingStatus,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
)

fun List<SpørreundersøkelseUtenInnhold>.tilDto(erEier: Boolean) = map { it.tilDto(erEier = erEier) }

fun SpørreundersøkelseUtenInnhold.tilDto(erEier: Boolean) =
    SpørreundersøkelseUtenInnholdDto(
        kartleggingId = if (erEier) kartleggingId.toString() else "",
        vertId = if (erEier) {
            vertId?.toString() ?: ""
        } else "",
        status = status,
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt.toKotlinLocalDateTime(),
        endretTidspunkt = endretTidspunkt?.toKotlinLocalDateTime(),
    )
