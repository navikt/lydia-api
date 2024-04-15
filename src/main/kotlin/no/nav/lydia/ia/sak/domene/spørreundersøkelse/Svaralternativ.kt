package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import java.util.UUID

data class Svaralternativ(
    val svarId: UUID,
    val svartekst: String,
)
