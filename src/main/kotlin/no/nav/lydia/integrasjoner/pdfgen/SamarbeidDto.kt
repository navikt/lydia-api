package no.nav.lydia.integrasjoner.pdfgen

import kotlinx.serialization.Serializable

@Serializable
data class SamarbeidDto(
    val id: Int,
    val navn: String,
)
