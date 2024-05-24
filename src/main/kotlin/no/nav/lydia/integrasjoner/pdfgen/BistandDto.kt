package no.nav.lydia.integrasjoner.pdfgen

import kotlinx.serialization.Serializable

@Serializable
data class BistandDto(
	val dato: String,
	val sak: SakDto,
	val arbeidsgiver: ArbeidsgiverDto
)