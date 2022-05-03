package no.nav.fia.virksomhet.domene

data class Virksomhet (
    val id: Long,
    val orgnr: String,
    val navn: String,
    val adresse: List<String>,
    val postnummer: Int,
    val poststed: String,
    val kommune: String,
    val kommunenummer: String,
    val land: String,
    val landkode: String,
    val næringsgrupper: List<Næringsgruppe>
)
