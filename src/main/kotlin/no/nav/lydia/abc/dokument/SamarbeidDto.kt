package no.nav.lydia.abc.dokument

import kotlinx.serialization.Serializable

@Serializable
data class SamarbeidDto(
    val id: Int,
    val navn: String,
)
