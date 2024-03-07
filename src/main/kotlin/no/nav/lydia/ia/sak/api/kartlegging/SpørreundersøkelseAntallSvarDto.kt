package no.nav.lydia.ia.sak.api.kartlegging

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.SpørreundersøkelseAntallSvar

@Serializable
data class SpørreundersøkelseAntallSvarDto(
	val spørreundersøkelseId: String,
	val spørsmålId: String,
	val antallSvar: Int,
)

fun SpørreundersøkelseAntallSvar.toDto() =
	SpørreundersøkelseAntallSvarDto(
		spørreundersøkelseId = spørreundersøkelseId.toString(),
		spørsmålId = spørsmålId.toString(),
		antallSvar = antallSvar
	)