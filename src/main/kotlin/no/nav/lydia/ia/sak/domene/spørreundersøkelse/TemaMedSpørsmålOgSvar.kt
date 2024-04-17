package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.serialization.Serializable

@Serializable
data class TemaMedSpørsmålOgSvar(
	val tema: String,
	val beskrivelse: String,
	val spørsmålMedSvar: List<SpørsmålMedSvar>
)

@Serializable
data class Svar(
	val svarId: String,
	val tekst: String,
	val antallSvar: Int
)

@Serializable
data class SpørsmålMedSvar(
	val spørsmålId: String,
	val tekst: String,
	val flervalg: Boolean,
	val svarListe: List<Svar>
)