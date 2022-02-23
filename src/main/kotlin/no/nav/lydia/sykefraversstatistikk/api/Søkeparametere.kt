package no.nav.lydia.sykefraversstatistikk.api

import io.ktor.http.*

data class Søkeparametere(
    val fylkesnummer: Set<String>,
    val kommunenummer: Set<String>,
    val næringsgruppeKoder: Set<String>,
    val sorteringsnøkkel: Sorteringsnøkkel,
    val sorteringsretning : Sorteringsretning
) {
    companion object {
        fun from(queryParameters: Parameters): Søkeparametere =
            Søkeparametere(
                fylkesnummer = queryParameters["fylker"]?.split(",")?.toSet() ?: emptySet(),
                kommunenummer = queryParameters["kommuner"]?.split(",")?.toSet() ?: emptySet(),
                næringsgruppeKoder = queryParameters["neringsgrupper"]?.split(",")?.toSet() ?: emptySet(),
                sorteringsnøkkel = Sorteringsnøkkel.from(queryParameters["sorteringsnokkel"]),
                sorteringsretning = Sorteringsretning.from(queryParameters["sorteringsretning"])
            )
    }

    fun erTom() = fylkesnummer.isEmpty() && kommunenummer.isEmpty() && næringsgruppeKoder.isEmpty()
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


