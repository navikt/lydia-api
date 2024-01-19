package no.nav.lydia.ia.sak.domene

import java.util.UUID

class SpørsmålOgSvaralternativer(
    val id: UUID,
    val kategori: String,
    val spørsmål: String,
    val svaralternativer: List<Svaralternativ>
)
