package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import java.util.UUID

data class Spørsmål(
    val spørsmålId: UUID,
    val undertemanavn: String,
    val spørsmåltekst: String,
    val svaralternativer: List<Svaralternativ>,
    val flervalg: Boolean,
)
