package no.nav.lydia.integrasjoner.pdfgen

import kotlinx.serialization.Serializable

@Serializable
data class VirksomhetDto(
	val orgnummer: String,
	val navn: String
)