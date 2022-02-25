package no.nav.lydia.virksomhet.brreg

import kotlinx.serialization.Serializable

@Serializable
data class VirksomhetDto(
    val organisasjonsnummer: String,
    val navn: String,
    val beliggenhetsadresse: Beliggenhetsadresse,
    val naeringskode1: NæringskodeBrreg,
    val naeringskode2: NæringskodeBrreg?,
    val naeringskode3: NæringskodeBrreg?,

){
    fun hentNæringsgrupper(): List<NæringskodeBrreg> = listOfNotNull(naeringskode1, naeringskode2, naeringskode3)
}

@Serializable
data class NæringskodeBrreg(
    val beskrivelse: String,
    val kode: String
)

@Serializable
data class Beliggenhetsadresse(val land: String, val landkode: String, val postnummer: String, val poststed: String, val kommune: String, val kommunenummer: String)
