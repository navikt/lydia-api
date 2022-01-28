package no.nav.lydia.virksomhet.brreg

data class VirksomhetDTO(
    val organisasjonsnummer: String,
    val navn: String,
    val beliggenhetsadresse: Beliggenhetsadresse,
)

data class Beliggenhetsadresse(val land: String, val landkode: String, val postnummer: Int, val poststed: String, val kommune: String, val kommunenummer: String)
