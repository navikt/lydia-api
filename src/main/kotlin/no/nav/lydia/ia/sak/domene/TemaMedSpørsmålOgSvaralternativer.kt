package no.nav.lydia.ia.sak.domene

data class TemaMedSpørsmålOgSvaralternativer(
	val tema: Tema,
	val spørsmålOgSvaralternativer: List<SpørsmålOgSvaralternativer>
)