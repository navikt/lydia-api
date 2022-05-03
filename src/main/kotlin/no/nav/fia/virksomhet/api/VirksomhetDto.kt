package no.nav.fia.virksomhet.api

import kotlinx.serialization.Serializable
import no.nav.fia.virksomhet.domene.Næringsgruppe
import no.nav.fia.virksomhet.domene.Virksomhet

@Serializable
data class VirksomhetDto(
    val orgnr: String,
    val navn: String,
    val adresse: List<String>,
    val postnummer: String,
    val poststed: String,
    val neringsgrupper: List<Næringsgruppe>
)

fun Virksomhet.toDto() = VirksomhetDto(
    orgnr = this.orgnr,
    navn = this.navn,
    adresse = this.adresse,
    postnummer = this.postnummer.toString().padStart(length = 4, padChar = '0'),
    poststed = this.poststed,
    neringsgrupper = this.næringsgrupper,
)
