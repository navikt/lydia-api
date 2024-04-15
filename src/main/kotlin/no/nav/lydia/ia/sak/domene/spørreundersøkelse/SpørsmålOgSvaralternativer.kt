package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import java.util.UUID

data class SpørsmålOgSvaralternativer(
	val spørsmålId: UUID,
	val spørsmåltekst: String,
	val svaralternativer: List<Svaralternativ>,
	val flervalg: Boolean,
)