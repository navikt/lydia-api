package no.nav.lydia.ia.sak.api.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

@Serializable
data class SpørreundersøkelseDto(
    val kartleggingId: String,
    val vertId: String,
    val status: SpørreundersøkelseStatus,
    val temaMedSpørsmålOgSvaralternativer: List<TemaDto>,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
)

fun Spørreundersøkelse.tilDto(erEier: Boolean) =
    SpørreundersøkelseDto(
        kartleggingId = if (erEier) id.toString() else "",
        vertId = if (erEier) {
            vertId?.toString() ?: ""
        } else "",
        status = status,
        temaMedSpørsmålOgSvaralternativer = if (erEier) tema.map { it.toDto() } else emptyList(),
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt.toKotlinLocalDateTime(),
        endretTidspunkt = endretTidspunkt?.toKotlinLocalDateTime(),
    )
