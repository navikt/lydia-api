package no.nav.lydia.ia.sak.api.kartlegging

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASakKartleggingOversikt
import no.nav.lydia.ia.sak.domene.KartleggingStatus

@Serializable
data class IASakKartleggingOversiktDto(
    val kartleggingId: String,
    val vertId: String,
    val status: KartleggingStatus,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?
)

fun List<IASakKartleggingOversikt>.toDto(erEier: Boolean) = map { it.toDto( erEier = erEier) }

fun IASakKartleggingOversikt.toDto(erEier: Boolean) =
    IASakKartleggingOversiktDto(
        kartleggingId = if (erEier) kartleggingId.toString() else "",
        vertId = if (erEier) { vertId?.toString() ?: "" } else "",
        status = status,
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt.toKotlinLocalDateTime(),
        endretTidspunkt = endretTidspunkt?.toKotlinLocalDateTime(),
    )
