package no.nav.lydia.sykefraversstatistikk.api

import io.ktor.http.*
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService

data class Søkeparametere(
    val kommunenummer: Set<String>,
    val næringsgruppeKoder: Set<String>,
    val sorteringsnøkkel: Sorteringsnøkkel,
    val sorteringsretning : Sorteringsretning
) {
    companion object {
        fun from(queryParameters: Parameters, geografiService: GeografiService): Søkeparametere =
            Søkeparametere(
                kommunenummer =  finnGyldigeKommunenummer(queryParameters, geografiService),
                næringsgruppeKoder = finnGyldigeNæringsgruppekoder(queryParameters),
                sorteringsnøkkel = Sorteringsnøkkel.from(queryParameters["sorteringsnokkel"]),
                sorteringsretning = Sorteringsretning.from(queryParameters["sorteringsretning"])
            )
        private fun finnGyldigeKommunenummer(queryParameters: Parameters, geografiService: GeografiService) =
            geografiService.hentKommunerFraFylkerOgKommuner(
                queryParameters["fylker"].tilUnikeVerdier(),
                queryParameters["kommuner"].tilUnikeVerdier(),
            )
        private fun finnGyldigeNæringsgruppekoder(queryParameters: Parameters) =
            queryParameters["neringsgrupper"].tilUnikeVerdier()

        private fun String?.tilUnikeVerdier() : Set<String> =
            this?.split(",")?.filter { it.isNotBlank() }?.toSet() ?: emptySet()
    }
}

enum class Sorteringsnøkkel(private val verdi: String) {
    TAPTE_DAGSVERK("tapte_dagsverk"),
    SYKEFRAVÆRSPROSENT("sykefraversprosent");

    companion object {
        fun from(verdi: String?): Sorteringsnøkkel =
            when (verdi?.lowercase()) {
                "tapte_dagsverk" -> TAPTE_DAGSVERK
                "sykefraversprosent" -> SYKEFRAVÆRSPROSENT
                else -> TAPTE_DAGSVERK
            }
        fun alleSorteringsNøkler() = values().map { it.toString() }
    }

    override fun toString(): String = this.verdi

}


enum class Sorteringsretning(private val retning: String) {
    SYNKENDE("desc"),
    STIGENDE("asc");

    companion object {
        fun from (verdi: String?) : Sorteringsretning =
            when (verdi?.lowercase()) {
                "asc" -> STIGENDE
                "desc" -> SYNKENDE
                else -> SYNKENDE
            }
    }
    override fun toString(): String = this.retning
}


