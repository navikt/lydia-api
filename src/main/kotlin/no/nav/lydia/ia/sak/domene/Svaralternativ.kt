package no.nav.lydia.ia.sak.domene

import java.util.UUID

data class Svaralternativ(
    val svarId: UUID,
    val svartekst: String,
    val antallSvar: Int,
)
