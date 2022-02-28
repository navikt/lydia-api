package no.nav.lydia.virksomhet.domene

import kotlinx.serialization.Serializable

@Serializable
data class Næringsgruppe(val navn: String, val kode: String)