package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import java.util.UUID

data class SpørreundersøkelseAntallSvar(
	val spørreundersøkelseId: UUID,
	val spørsmålId: UUID,
	val antallSvar: Int,
)