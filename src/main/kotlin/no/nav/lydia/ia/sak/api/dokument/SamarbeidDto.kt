package no.nav.lydia.ia.sak.api.dokument

import kotlinx.serialization.Serializable

@Serializable
data class SamarbeidDto(
    val id: Int,
    val navn: String,
)
