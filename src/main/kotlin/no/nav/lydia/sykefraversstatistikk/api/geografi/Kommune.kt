package no.nav.lydia.sykefraversstatistikk.api.geografi

import kotlinx.serialization.Serializable

@Serializable
data class Kommune(val navn: String, val nummer: String) {
    companion object {
        fun kommune(kommuneNavn: String?, kommuneNummer: String?): Kommune? {
            if(kommuneNavn != null && kommuneNummer != null)
                return Kommune(kommuneNavn, kommuneNummer)
            else return null
        }
    }
}
