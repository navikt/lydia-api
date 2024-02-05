package no.nav.lydia.ia.sak.domene

import java.util.UUID

data class IASakKartlegging(
    val kartleggingId: UUID,
    val vertId: UUID?,
    val saksnummer: String,
    val status: KartleggingStatus,
    val spørsmålOgSvaralternativer: List<SpørsmålOgSvaralternativer>,
)