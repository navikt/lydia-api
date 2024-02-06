package no.nav.lydia.ia.sak.domene

import java.util.UUID

data class SpørsmålOgSvaralternativer(
    val spørsmålId: UUID,
    val kategori: String,
    val spørsmåltekst: String,
    val antallSvar: Int,
    val svaralternativer: List<Svaralternativ>,
)
