package no.nav.lydia.ia.sak.domene

import java.util.UUID

class SpørsmålOgSvaralternativer(
    val spørsmålId: UUID,
    val kategori: String,
    val spørsmåltekst: String,
    val svaralternativer: List<Svaralternativ>
)
