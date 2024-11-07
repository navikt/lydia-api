package no.nav.lydia.ia.sak.api.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

@Serializable
data class SpørreundersøkelseDto(
    val id: String,
    @Deprecated("Bruk id")
    val kartleggingId: String,
    val samarbeidId: Int,
    @Deprecated("Bruk samarbeidId")
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
        id = if (erEier) id.toString() else "",
        kartleggingId = if (erEier) id.toString() else "",
        samarbeidId = samarbeidId,
        prosessId = samarbeidId,
        status = status,
        temaMedSpørsmålOgSvaralternativer = if (erEier) tema.map { it.toDto() } else emptyList(),
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt.toKotlinLocalDateTime(),
        type = type,
        endretTidspunkt = endretTidspunkt?.toKotlinLocalDateTime(),
    )
