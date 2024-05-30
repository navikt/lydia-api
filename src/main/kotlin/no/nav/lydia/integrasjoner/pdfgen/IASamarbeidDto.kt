package no.nav.lydia.integrasjoner.pdfgen

import kotlinx.serialization.Serializable

@Serializable
data class IASamarbeidDto(
	val dato: String,
	val sak: SakDto,
	val virksomhet: VirksomhetDto
)