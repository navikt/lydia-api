package no.nav.lydia.ia.sak.api.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

@Serializable
data class SpørreundersøkelseDto(
    val kartleggingId: String,
    val prosessId: Int,
    val status: SpørreundersøkelseStatus,
    val temaMedSpørsmålOgSvaralternativer: List<TemaDto>,
    val opprettetAv: String,
    val type: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
)

fun Spørreundersøkelse.tilDto(erEier: Boolean) =
    SpørreundersøkelseDto(
        kartleggingId = if (erEier) id.toString() else "",
        prosessId = prosessId,
        status = status,
        temaMedSpørsmålOgSvaralternativer = if (erEier) tema.map { it.toDto() } else emptyList(),
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt.toKotlinLocalDateTime(),
        type = type,
        endretTidspunkt = endretTidspunkt?.toKotlinLocalDateTime(),
    )
