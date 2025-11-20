package no.nav.lydia.ia.sak.api.dokument

import kotlinx.serialization.Serializable

@Serializable
data class VirksomhetDto(
    val orgnummer: String,
    val navn: String,
)
