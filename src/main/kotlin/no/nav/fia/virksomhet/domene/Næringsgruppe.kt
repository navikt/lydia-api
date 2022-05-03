package no.nav.fia.virksomhet.domene

import kotlinx.serialization.Serializable

@Serializable
data class Næringsgruppe(val navn: String, val kode: String)