package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import java.util.UUID

data class Svaralternativ(
    val id: UUID,
    val tekst: String,
    val antallSvar: Int,
)
