package no.nav.lydia.integrasjoner.brreg

import kotlinx.serialization.Serializable
import no.nav.lydia.virksomhet.domene.Næringsgruppe

@Serializable
data class BrregVirksomhetDto(
    val organisasjonsnummer: String,
    val navn: String,
    val beliggenhetsadresse: Beliggenhetsadresse?,
    val naeringskode1: NæringsundergruppeBrreg?,
    val naeringskode2: NæringsundergruppeBrreg?,
    val naeringskode3: NæringsundergruppeBrreg?,

    ){
    fun hentNæringsgruppekoder() = mutableMapOf(
        "naeringskode1" to hentNæringskode1()).apply {
            naeringskode2?.let { this["naeringskode2"] = it.kode }
            naeringskode3?.let { this["naeringskode3"] = it.kode }
    }

    private fun hentNæringskode1() = (naeringskode1?.kode ?: Næringsgruppe.UOPPGITT.kode)
}

@Serializable
data class NæringsundergruppeBrreg(
    val beskrivelse: String,
    val kode: String
)

@Serializable
data class Beliggenhetsadresse(
    val land: String?,
    val landkode: String?,
    val postnummer: String?,
    val poststed: String?,
    val adresse: List<String>?,
    val kommune: String?,
    val kommunenummer: String?) {
    // TODO: hva definerer en relevant virksomhet i kontekst av beliggenhet
    fun erRelevant() =
        listOf(land, landkode, postnummer, poststed, kommune, kommunenummer).all { !it.isNullOrBlank() }

}
