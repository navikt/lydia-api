package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable

@Serializable
data class SpørreundersøkelseDto (
	val spørreundersøkelseId: String,
	val vertId: String,
	val status: KartleggingStatus,
	val type: String,
	val temaMedSpørsmålOgSvaralternativer: List<TemaMedSpørsmålOgSvaralternativerDto>,
	val avslutningsdato: LocalDate
)