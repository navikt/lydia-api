package no.nav.lydia.virksomhet.domene

import kotlinx.serialization.Serializable

@Serializable
data class Næringsgruppe(val navn: String, val kode: String) {
    companion object {
        val UOPPGITT = Næringsgruppe(navn = "Uoppgitt", kode = "00.000")
    }
}
