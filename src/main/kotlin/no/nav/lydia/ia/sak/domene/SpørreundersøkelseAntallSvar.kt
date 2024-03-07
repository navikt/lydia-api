package no.nav.lydia.ia.sak.domene

import java.util.*

data class SpørreundersøkelseAntallSvar(
	val spørreundersøkelseId: UUID,
	val spørsmålId: UUID,
	val antallSvar: Int,
)