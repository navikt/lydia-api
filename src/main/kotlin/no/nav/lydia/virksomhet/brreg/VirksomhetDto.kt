package no.nav.lydia.virksomhet.brreg

import kotlinx.serialization.Serializable

@Serializable
data class VirksomhetDto(
    val organisasjonsnummer: String,
    val navn: String,
    val beliggenhetsadresse: Beliggenhetsadresse,
)

@Serializable
data class Beliggenhetsadresse(val land: String, val landkode: String, val postnummer: Int, val poststed: String, val kommune: String, val kommunenummer: String)
