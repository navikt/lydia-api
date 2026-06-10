package no.nav.lydia.dokumentpublisering

import kotlinx.serialization.Serializable

@Serializable
data class SamarbeidDto(
    val id: Int,
    val navn: String,
)
