package no.nav.lydia.virksomhet.domene

import kotlinx.serialization.Serializable

/**  Vi bør følge SSB sin standard, og bruke f.eks "næring" om 2-sifrede koder og "næringsundergruppe" om 5-sifrede koder.
    Ref https://www.ssb.no/a/publikasjoner/pdf/nos_d383/nos_d383.pdf
*/
//TODO Rename
@Serializable
data class Næringsgruppe(val navn: String, val kode: String) {
    companion object {
        val UOPPGITT = Næringsgruppe(navn = "Uoppgitt", kode = "00.000")
    }
}
