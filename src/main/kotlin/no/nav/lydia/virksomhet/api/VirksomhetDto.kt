package no.nav.lydia.virksomhet.api

import kotlinx.serialization.Serializable
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.Virksomhet

@Serializable
data class VirksomhetDto(
    val orgnr: String,
    val navn: String,
    val adresse: List<String>,
    val postnummer: String,
    val poststed: String,
    val neringsgrupper: List<Næringsgruppe>,
    val sektor: String
)

fun Virksomhet.toDto() = VirksomhetDto(
    orgnr = this.orgnr,
    navn = this.navn,
    adresse = this.adresse,
    postnummer = this.postnummer,
    poststed = this.poststed,
    neringsgrupper = this.næringsgrupper,
    sektor = sektorKodeTilBeskrivelse()
)

fun Virksomhet.sektorKodeTilBeskrivelse(): String {
    return when (sektor) {
        "1" -> "Statlig forvaltning"
        "2" -> "Kommunal forvaltning"
        "3" -> "Privat og offentlig næringsvirksomhet"
        else -> "Ukjent"
    }
}
