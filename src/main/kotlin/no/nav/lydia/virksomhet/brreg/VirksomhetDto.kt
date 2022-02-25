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
    fun hentNæringsgruppekoder() = mutableMapOf(
        "naeringskode1" to naeringskode1.kode).apply {
            naeringskode2?.let { this["naeringskode2"] = it.kode }
            naeringskode3?.let { this["naeringskode3"] = it.kode }
    }
}

@Serializable
data class NæringskodeBrreg(
    val beskrivelse: String,
    val kode: String
)

@Serializable
data class Beliggenhetsadresse(val land: String, val landkode: String, val postnummer: String, val poststed: String, val kommune: String, val kommunenummer: String)
