package no.nav.lydia.abc.dokument

import kotlinx.serialization.Serializable

@Serializable
data class VirksomhetDto(
    val orgnummer: String,
    val navn: String,
)
