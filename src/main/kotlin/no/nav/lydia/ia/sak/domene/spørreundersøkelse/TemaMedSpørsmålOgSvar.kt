package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.serialization.Serializable
import no.nav.lydia.integrasjoner.kartlegging.SpørsmålMedSvar

@Serializable
data class TemaMedSpørsmålOgSvar(
	val tema: String,
	val beskrivelse: String,
	val spørsmålMedSvar: List<SpørsmålMedSvar>
)