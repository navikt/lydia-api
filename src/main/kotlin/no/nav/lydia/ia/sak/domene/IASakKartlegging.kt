package no.nav.lydia.ia.sak.domene

import java.util.UUID

class IASakKartlegging(
    val id: UUID,
    val saksnummer: String,
    val status: String,
    val spørsmålOgSvaralternativer: List<SpørsmålOgSvaralternativer>
)