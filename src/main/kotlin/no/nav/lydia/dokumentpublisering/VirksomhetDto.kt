package no.nav.lydia.dokumentpublisering

import kotlinx.serialization.Serializable

@Serializable
data class VirksomhetDto(
    val orgnummer: String,
    val navn: String,
)
