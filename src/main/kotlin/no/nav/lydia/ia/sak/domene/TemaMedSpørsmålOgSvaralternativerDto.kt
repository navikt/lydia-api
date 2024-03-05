package no.nav.lydia.ia.sak.domene

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.api.kartlegging.SpørsmålOgSvaralternativerDto
import no.nav.lydia.ia.sak.api.kartlegging.toDto

@Serializable
data class TemaMedSpørsmålOgSvaralternativerDto(
	val temanavn: Temanavn,
	val spørsmålOgSvaralternativer: List<SpørsmålOgSvaralternativerDto>
)

fun TemaMedSpørsmålOgSvaralternativer.toDto() =
	TemaMedSpørsmålOgSvaralternativerDto(
		this.tema.navn,
		this.spørsmålOgSvaralternativer.toDto()
	)