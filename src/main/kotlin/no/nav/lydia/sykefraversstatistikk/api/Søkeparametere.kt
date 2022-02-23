package no.nav.lydia.sykefraversstatistikk.api

import io.ktor.http.*

data class Søkeparametere(
    val fylkesnummer: Set<String>, val kommunenummer: Set<String>,
    val næringsgruppeKoder: Set<String>, val sortering: Sortering
) {
    companion object {
        fun from(queryParameters: Parameters): Søkeparametere =
            Søkeparametere(
                fylkesnummer = queryParameters["fylker"]?.split(",")?.toSet() ?: emptySet(),
                kommunenummer = queryParameters["kommuner"]?.split(",")?.toSet() ?: emptySet(),
                næringsgruppeKoder = queryParameters["neringsgrupper"]?.split(",")?.toSet() ?: emptySet(),
                sortering = Sortering.from(queryParameters["sortering"])
            )
    }

    fun erTom() = fylkesnummer.isEmpty() && kommunenummer.isEmpty() && næringsgruppeKoder.isEmpty()
}

enum class Sortering(val verdi: String, val retning: String) {
    TAPTE_DAGSVERK_SYNKENDE("tapte_dagsverk", "desc"),
    SYKEFRAVÆRSPROSENT_SYNKENDE("sykefraversprosent", "desc");

    companion object {
        fun from(verdi: String?): Sortering =
            when (verdi) {
                "tapte_dagsverk_desc" -> TAPTE_DAGSVERK_SYNKENDE
                "sykefraversprosent_desc" -> SYKEFRAVÆRSPROSENT_SYNKENDE
                else -> TAPTE_DAGSVERK_SYNKENDE
            }
    }
}



