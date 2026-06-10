package no.nav.lydia.kartlegging

import java.util.UUID

data class Svaralternativ(
    val id: UUID,
    val tekst: String,
    val antallSvar: Int,
)
