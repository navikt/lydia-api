package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.IASakKartlegging
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.KartleggingStatus
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaMedSpørsmålOgSvaralternativerDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.toDto

@Serializable
data class IASakKartleggingDto(
    val kartleggingId: String,
    val vertId: String,
    val status: KartleggingStatus,
    val temaMedSpørsmålOgSvaralternativer: List<TemaMedSpørsmålOgSvaralternativerDto>,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
)

fun List<IASakKartlegging>.toDto(erEier: Boolean) = map { it.toDto(erEier = erEier) }

fun IASakKartlegging.toDto(erEier: Boolean) =
    IASakKartleggingDto(
        kartleggingId = if (erEier) kartleggingId.toString() else "",
        vertId = if (erEier) {
            vertId?.toString() ?: ""
        } else "",
        status = status,
        temaMedSpørsmålOgSvaralternativer = if (erEier) temaMedSpørsmålOgSvaralternativer.map { it.toDto() } else emptyList(),
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt.toKotlinLocalDateTime(),
        endretTidspunkt = endretTidspunkt?.toKotlinLocalDateTime(),
    )
