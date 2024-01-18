package no.nav.lydia.ia.sak.domene

import no.nav.lydia.ia.sak.api.IASakKartleggingDto
import java.util.UUID

class IASakKartlegging(
    val kartleggingId: UUID
) {
    fun toDto() =
        IASakKartleggingDto(kartleggingId = kartleggingId.toString())
}