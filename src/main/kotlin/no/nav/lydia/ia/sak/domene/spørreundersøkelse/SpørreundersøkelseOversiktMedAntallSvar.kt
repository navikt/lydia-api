package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import java.util.*

data class SpørreundersøkelseOversiktMedAntallSvar(
	val kartleggingId: UUID,
	val antallUnikeDeltakereMedMinstEttSvar: Int,
	val antallUnikeDeltakereSomHarSvartPåAlt: Int,
	val spørsmålMedAntallSvarPerTema: List<TemaMedAntallSvar>
)
