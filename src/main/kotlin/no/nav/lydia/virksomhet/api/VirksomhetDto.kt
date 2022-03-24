package no.nav.lydia.virksomhet.api

import kotlinx.serialization.Serializable
import no.nav.lydia.virksomhet.domene.Næringsgruppe

@Serializable
data class VirksomhetDto(
    val orgnr: String,
    val navn: String,
    val adresse: List<String>,
    val neringsgrupper: List<Næringsgruppe>
)
