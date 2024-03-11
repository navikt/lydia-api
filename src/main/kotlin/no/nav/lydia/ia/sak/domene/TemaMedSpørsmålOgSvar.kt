package no.nav.lydia.ia.sak.domene

import kotlinx.serialization.Serializable
import no.nav.lydia.integrasjoner.kartlegging.SpørsmålMedSvar

@Serializable
data class TemaMedSpørsmålOgSvar(
	val tema: String,
	val spørsmålMedSvar: List<SpørsmålMedSvar>
)