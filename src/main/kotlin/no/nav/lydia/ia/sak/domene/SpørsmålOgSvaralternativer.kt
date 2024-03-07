package no.nav.lydia.ia.sak.domene

import java.util.UUID

data class SpørsmålOgSvaralternativer(
    val spørsmålId: UUID,
    val tema: Tema,
    val spørsmåltekst: String,
    val svaralternativer: List<Svaralternativ>,
) {
    enum class Tema {
        PARTSSAMARBEID,
    }
}
