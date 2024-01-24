package no.nav.lydia.ia.sak.domene

import java.util.UUID

class IASakKartlegging(
    val kartleggingId: UUID,
    val saksnummer: String,
    val status: String,
    val spørsmålOgSvaralternativer: List<SpørsmålOgSvaralternativer>
)