package no.nav.lydia.ia.sak.domene

import java.util.UUID

data class SpørsmålOgSvaralternativer(
    val spørsmålId: UUID,
    val spørsmåltekst: String,
    val svaralternativer: List<Svaralternativ>,
)