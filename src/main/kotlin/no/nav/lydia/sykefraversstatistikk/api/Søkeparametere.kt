package no.nav.lydia.sykefraversstatistikk.api

import io.ktor.http.Parameters
import io.ktor.server.application.*
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.tilgangskontroll.navIdent

data class Søkeparametere(
    val kommunenummer: Set<String>,
    val næringsgruppeKoder: Set<String>,
    val periode: Periode,
    val sorteringsnøkkel: Sorteringsnøkkel,
    val sorteringsretning: Sorteringsretning,
    val sykefraværsprosentFra: Double?,
    val sykefraværsprosentTil: Double?,
    val ansatteFra: Int?,
    val ansatteTil: Int?,
    val status: IAProsessStatus?,
    val side: Int,
    val navIdenter: Set<String>
) {
    companion object {
        const val VIRKSOMHETER_PER_SIDE = 50

        const val KVARTAL = "kvartal"
        const val ÅRSTALL = "arstall"
        const val KOMMUNER = "kommuner"
        const val FYLKER = "fylker"
        const val NÆRINGSGRUPPER = "neringsgrupper"
        const val SORTERINGSNØKKEL = "sorteringsnokkel"
        const val SORTERINGSRETNING = "sorteringsretning"
        const val SYKEFRAVÆRSPROSENT_FRA = "sykefraversprosentFra"
        const val SYKEFRAVÆRSPROSENT_TIL = "sykefraversprosentTil"
        const val ANSATTE_FRA = "ansatteFra"
        const val ANSATTE_TIL = "ansatteTil"
        const val IA_STATUS = "iaStatus"
        const val SIDE = "side"
        const val KUN_MINE_VIRKSOMHETER = "kunMineVirksomheter"

        fun from(call: ApplicationCall, geografiService: GeografiService) =
            call.request.queryParameters.let { queryParameters ->
                Søkeparametere(
                    kommunenummer = finnGyldigeKommunenummer(queryParameters, geografiService),
                    næringsgruppeKoder = finnGyldigeNæringsgruppekoder(queryParameters),
                    periode = Periode.from(
                        queryParameters[KVARTAL].tomSomNull(),
                        queryParameters[ÅRSTALL].tomSomNull()
                    ),
                    sorteringsnøkkel = Sorteringsnøkkel.from(queryParameters[SORTERINGSNØKKEL]),
                    sorteringsretning = Sorteringsretning.from(queryParameters[SORTERINGSRETNING]),
                    sykefraværsprosentFra = queryParameters[SYKEFRAVÆRSPROSENT_FRA].tomSomNull()?.toDouble(),
                    sykefraværsprosentTil = queryParameters[SYKEFRAVÆRSPROSENT_TIL].tomSomNull()?.toDouble(),
                    ansatteFra = queryParameters[ANSATTE_FRA].tomSomNull()?.toInt(),
                    ansatteTil = queryParameters[ANSATTE_TIL].tomSomNull()?.toInt(),
                    status = queryParameters[IA_STATUS].tomSomNull()?.let { IAProsessStatus.valueOf(it) },
                    side = queryParameters[SIDE].tomSomNull()?.toInt() ?: 1,
                    navIdenter = if (queryParameters[KUN_MINE_VIRKSOMHETER].toBoolean()) call.navIdent()
                        ?.let { navIdent -> setOf(navIdent) } ?: emptySet() else emptySet()
                )
            }

        private fun finnGyldigeKommunenummer(queryParameters: Parameters, geografiService: GeografiService) =
            geografiService.hentKommunerFraFylkerOgKommuner(
                queryParameters[FYLKER].tilUnikeVerdier(),
                queryParameters[KOMMUNER].tilUnikeVerdier(),
            )

        private fun finnGyldigeNæringsgruppekoder(queryParameters: Parameters) =
            queryParameters[NÆRINGSGRUPPER].tilUnikeVerdier()

        private fun String?.tilUnikeVerdier(): Set<String> =
            this?.split(",")?.filter { it.isNotBlank() }?.toSet() ?: emptySet()

        private fun String?.tomSomNull() = this?.ifBlank { null }
    }

    fun virksomheterPerSide() = VIRKSOMHETER_PER_SIDE
    fun offset() = (side - 1) * VIRKSOMHETER_PER_SIDE
}

class Periode(val kvartal: Int, val årstall: Int) {
    companion object {
        fun from(kvartal: String?, årstall: String?) =
            Periode(
                kvartal = kvartal?.toInt() ?: sisteKvartal(),
                årstall = årstall?.toInt() ?: sisteÅr()
            )

        private fun sisteKvartal() = 1
        private fun sisteÅr() = 2022

        fun gjeldendePeriode() =
            Periode(kvartal = sisteKvartal(), årstall = sisteÅr())

        fun forrigePeriode() =
            when (sisteKvartal()) {
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
        fun from(verdi: String?): Sorteringsretning =
            when (verdi?.lowercase()) {
                "asc" -> STIGENDE
                "desc" -> SYNKENDE
                else -> SYNKENDE
            }
    }

    override fun toString(): String = this.retning
}


