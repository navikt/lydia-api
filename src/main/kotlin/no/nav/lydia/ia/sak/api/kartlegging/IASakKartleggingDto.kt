package no.nav.lydia.ia.sak.api.kartlegging

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASakKartlegging
import no.nav.lydia.ia.sak.domene.KartleggingStatus

@Serializable
data class IASakKartleggingDto(
    val kartleggingId: String,
    val status: KartleggingStatus,
    val spørsmålOgSvaralternativer: List<SpørsmålOgSvaralternativerDto>,
)

fun List<IASakKartlegging>.toDto() = map { it.toDto() }

fun IASakKartlegging.toDto() =
    IASakKartleggingDto(
        kartleggingId = kartleggingId.toString(),
        status = status,
        spørsmålOgSvaralternativer = spørsmålOgSvaralternativer.toDto(),
    )
