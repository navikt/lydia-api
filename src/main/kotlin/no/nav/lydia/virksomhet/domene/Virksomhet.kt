package no.nav.lydia.virksomhet.domene

data class Virksomhet (
    val id: Long,
    val orgnr: String,
    val land: String,
    val landkode: String,
    val postnummer: Int,
    val poststed: String,
    val kommune: String,
    val kommunenummer: String
)
