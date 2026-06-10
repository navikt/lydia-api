package no.nav.lydia.abc.dokumentpublisering

import kotlinx.serialization.Serializable

@Serializable
data class SamarbeidDto(
    val id: Int,
    val navn: String,
)
