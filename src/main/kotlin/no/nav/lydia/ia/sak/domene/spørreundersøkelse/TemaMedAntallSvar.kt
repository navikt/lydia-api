package no.nav.lydia.ia.sak.domene.spørreundersøkelse

data class TemaMedAntallSvar(
	val tema: Tema,
	val antallSpørsmål: Int,
	val antallUnikeDeltakereMedMinstEttSvar: Int,
	val antallUnikeDeltakereSomHarSvartPåAlt: Int,
	val status: TemaStatus
)
