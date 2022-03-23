package no.nav.lydia.sykefraversstatistikk.api

import io.ktor.http.*
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService

data class Søkeparametere(
    val kommunenummer: Set<String>,
    val næringsgruppeKoder: Set<String>,
    val periode: Periode,
    val sorteringsnøkkel: Sorteringsnøkkel,
    val sorteringsretning : Sorteringsretning,
    val sykefraværsprosentFra: Double?,
    val sykefraværsprosentTil: Double?
) {
    companion object {
        fun from(queryParameters: Parameters, geografiService: GeografiService): Søkeparametere =
            Søkeparametere(
                kommunenummer =  finnGyldigeKommunenummer(queryParameters, geografiService),
                næringsgruppeKoder = finnGyldigeNæringsgruppekoder(queryParameters),
                periode = Periode.from(queryParameters["kvartal"], queryParameters["arstall"]),
                sorteringsnøkkel = Sorteringsnøkkel.from(queryParameters["sorteringsnokkel"]),
                sorteringsretning = Sorteringsretning.from(queryParameters["sorteringsretning"]),
                sykefraværsprosentFra = when (val fra = queryParameters["sykefraversprosentFra"]?.toDouble()) {
                    0.0 -> null
                    else -> fra
                },
                sykefraværsprosentTil = when (val til = queryParameters["sykefraversprosentTil"]?.toDouble()) {
                    100.0 -> null
                    else -> til
                }
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

class Periode(val kvartal: Int, val årstall: Int) {
    companion object {
        fun from(kvartal: String?, årstall: String?) =
            Periode(
                kvartal = kvartal?.toInt() ?: sisteKvartal(),
                årstall = årstall?.toInt() ?: sisteÅr())

        private fun sisteKvartal() = 4
        private fun sisteÅr() = 2021

        fun gjeldenePeriode() =
            Periode(kvartal = sisteKvartal(), årstall = sisteÅr())
        fun forrigePeriode() =
            when(sisteKvartal()) {
                1 -> Periode(kvartal = 4, årstall = sisteÅr() - 1)
                else -> Periode(kvartal = sisteKvartal() - 1, årstall = sisteÅr())
            }
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


