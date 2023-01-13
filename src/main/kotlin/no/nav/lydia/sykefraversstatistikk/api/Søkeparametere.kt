package no.nav.lydia.sykefraversstatistikk.api

import arrow.core.*
import ia.felles.definisjoner.bransjer.Bransjer
import io.ktor.http.*
import io.ktor.server.request.*
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.Sykefraværsprosent.Companion.tilSykefraværsProsent
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.sykefraversstatistikk.import.Kvartal
import no.nav.lydia.tilgangskontroll.Rådgiver
import no.nav.lydia.tilgangskontroll.Rådgiver.Rolle.*

data class Søkeparametere(
    val kommunenummer: Set<String>,
    val næringsgruppeKoder: Set<String>,
    val periode: Periode,
    val sorteringsnøkkel: Sorteringsnøkkel,
    val sorteringsretning: Sorteringsretning,
    val sykefraværsprosentFra: Sykefraværsprosent?,
    val sykefraværsprosentTil: Sykefraværsprosent?,
    val ansatteFra: Int?,
    val ansatteTil: Int?,
    val status: IAProsessStatus?,
    val side: Int,
    val navIdenter: Set<String>,
    val bransjeprogram: Set<Bransjer>,
) {
    companion object {
        const val VIRKSOMHETER_PER_SIDE = 100

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
        const val BRANSJEPROGRAM = "bransjeprogram"
        const val IA_SAK_EIERE = "eiere"

        fun ApplicationRequest.søkeparametere(geografiService: GeografiService, rådgiver: Rådgiver) =
                queryParameters[SYKEFRAVÆRSPROSENT_FRA].tilSykefraværsProsent().zip(
                    queryParameters[SYKEFRAVÆRSPROSENT_TIL].tilSykefraværsProsent(),
                    Periode.tilValidertPeriode(kvartal = queryParameters[KVARTAL], årstall = queryParameters[ÅRSTALL]),
                    queryParameters[SIDE].tomSomNull()?.tilValidertHeltall() ?: Valid(1),
                    queryParameters[ANSATTE_FRA].tomSomNull()?.tilValidertHeltall() ?: Valid(null),
                    queryParameters[ANSATTE_TIL].tomSomNull()?.tilValidertHeltall() ?: Valid(null)
                ) { sykefraværsProsentFra, sykefraværsProsentTil, periode, side, ansatteFra, ansatteTil ->
                    Søkeparametere(
                        sykefraværsprosentFra = sykefraværsProsentFra,
                        sykefraværsprosentTil = sykefraværsProsentTil,
                        periode = periode,
                        side = side,
                        ansatteFra = ansatteFra,
                        ansatteTil = ansatteTil,
                        kommunenummer = finnGyldigeKommunenummer(queryParameters, geografiService),
                        næringsgruppeKoder = finnGyldigeNæringsgruppekoder(queryParameters),
                        sorteringsnøkkel = Sorteringsnøkkel.from(queryParameters[SORTERINGSNØKKEL]),
                        sorteringsretning = Sorteringsretning.from(queryParameters[SORTERINGSRETNING]),
                        status = queryParameters[IA_STATUS].tomSomNull()?.let { IAProsessStatus.valueOf(it) },
                        navIdenter = navIdenter(rådgiver = rådgiver),
                        bransjeprogram = finnBransjeProgram(queryParameters[BRANSJEPROGRAM]),
                    )
            }.mapLeft {
                Feil(it.joinToString(separator = "\n"), HttpStatusCode.BadRequest)
            }.toEither()

        private fun ApplicationRequest.navIdenter(rådgiver: Rådgiver): Set<String> {
            return queryParameters[IA_SAK_EIERE].tilUnikeVerdier().let { eiere ->
                when (rådgiver.rolle) {
                    SUPERBRUKER -> eiere.toSet()
                    SAKSBEHANDLER,
                    LESE,
                    -> eiere.filter { it == rådgiver.navIdent }.toSet()
                }
            }
        }

        private fun finnBransjeProgram(queryParams: String?): Set<Bransjer> {
            val unikeVerdier = queryParams.tilUnikeVerdier().map(String::uppercase)
            return Bransjer.values().filter { it.name in unikeVerdier }.toSet()
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

    }

    fun virksomheterPerSide() = VIRKSOMHETER_PER_SIDE
    fun offset() = (side - 1) * VIRKSOMHETER_PER_SIDE

    internal fun næringsgrupperMedBransjer() = næringsgruppeKoder.toMutableSet().apply {
        addAll(
            bransjeprogram.flatMap { bransje ->
                bransje.næringskoder.map { næringskode ->
                    if (næringskode.length == 5) "${næringskode.take(2)}.${næringskode.takeLast(3)}"
                    else næringskode
                }
            }
        )
    }.toSet()
}

class Periode(val kvartal: Int, val årstall: Int) {
    companion object {
        fun tilValidertPeriode(kvartal: String?, årstall: String?) =
            kvartal.tilValidertKvartal().zip(
                årstall.tomSomNull()?.tilValidertHeltall() ?: Valid(sisteÅr())
            ) {
                validertKvartal, validertÅrstall -> Periode(kvartal = validertKvartal, årstall = validertÅrstall)
            }

        private fun String?.tilValidertKvartal() =
            tomSomNull()?.tilValidertHeltall()?.andThen {
                if ((1 .. 4).contains(it))
                    it.valid()
                else
                    "$it er ikke et gyldig kvartal. Kvartal er forventet å være 1 >= kvartal <= 4".invalidNel()
            } ?: Valid(sisteKvartal())

        private fun sisteKvartal() = 3
        private fun sisteÅr() = 2022

        fun gjeldendePeriode() =
            Periode(kvartal = sisteKvartal(), årstall = sisteÅr())

        fun forrigePeriode() =
            gjeldendePeriode().forrigePeriode()
    }
    fun tilKvartal() = Kvartal(årstall = årstall, kvartal = kvartal)

    fun forrigePeriode() =
        when (this.kvartal) {
            1 -> Periode(kvartal = 4, årstall = this.årstall - 1)
            else -> Periode(kvartal = this.kvartal - 1, årstall = this.årstall)
        }
}

enum class Sorteringsnøkkel(val verdi: String) {
    NAVN_PÅ_VIRKSOMHET("navn"),
    TAPTE_DAGSVERK("tapte_dagsverk"),
    ANTALL_PERSONER("antall_personer"),
    MULIGE_DAGSVERK("mulige_dagsverk"),
    SYKEFRAVÆRSPROSENT("sykefraversprosent");

    companion object {
        fun from(verdi: String?) = values().find { it.verdi == verdi?.lowercase() } ?: TAPTE_DAGSVERK
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

class Sykefraværsprosent private constructor(val sykefraværsProsent: Double) {
    companion object {
        fun String?.tilSykefraværsProsent(): ValidatedNel<String, Sykefraværsprosent?> =
            tomSomNull()?.tilValidertFlyttall()?.andThen { it.tilSykefraværsProsent() } ?: Valid(null)

        fun Double.tilSykefraværsProsent(): ValidatedNel<String, Sykefraværsprosent> =
            if (this.isFinite() && (0.0..100.0).contains(this))
                Sykefraværsprosent(this).valid()
            else
                "$this er ikke en gyldig sykefraværsprosent. Sykefraværsprosent er forventet å være '0.0 >= prosent <= 100.0'".invalidNel()
    }

    override fun toString() = sykefraværsProsent. toString()
}

private fun String.tilValidertFlyttall() = try {
    this.toDouble().valid()
} catch (e: Exception) {
    "$this er ikke et gyldig flyttall".invalidNel()
}

private fun String.tilValidertHeltall() = try {
    this.toInt().valid()
} catch (e: Exception) {
    "$this er ikke et gyldig heltall".invalidNel()
}

private fun String?.tomSomNull() = this?.ifBlank { null }
