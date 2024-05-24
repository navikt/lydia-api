package no.nav.lydia.integrasjoner.pdfgen

import kotlinx.serialization.Serializable

@Serializable
data class ArbeidsgiverDto(
	val orgnummer: String,
	val navn: String
)