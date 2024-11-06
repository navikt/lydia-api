package no.nav.lydia.integrasjoner.pdfgen

import kotlinx.serialization.Serializable

@Serializable
data class SakDto(
    val saksnummer: String,
    val navenhet: String,
)
