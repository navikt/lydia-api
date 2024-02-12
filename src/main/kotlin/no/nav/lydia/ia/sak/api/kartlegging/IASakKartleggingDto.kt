package no.nav.lydia.ia.sak.api.kartlegging

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASakKartlegging
import no.nav.lydia.ia.sak.domene.KartleggingStatus

@Serializable
data class IASakKartleggingDto(
    val kartleggingId: String,
    val vertId: String,
    val status: KartleggingStatus,
    val spørsmålOgSvaralternativer: List<SpørsmålOgSvaralternativerDto>,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?
)

fun List<IASakKartlegging>.toDto(erEier: Boolean) = map { it.toDto( erEier = erEier) }

fun IASakKartlegging.toDto(erEier: Boolean) =
    IASakKartleggingDto(
        kartleggingId = if (erEier) kartleggingId.toString() else "",
        vertId = if (erEier) { vertId?.toString() ?: "" } else "",
        status = status,
        spørsmålOgSvaralternativer = if (erEier) spørsmålOgSvaralternativer.toDto() else emptyList(),
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt.toKotlinLocalDateTime(),
        endretTidspunkt = endretTidspunkt?.toKotlinLocalDateTime(),
    )
