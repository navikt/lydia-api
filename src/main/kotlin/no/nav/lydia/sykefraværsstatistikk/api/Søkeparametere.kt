package no.nav.lydia.sykefraværsstatistikk.api

import arrow.core.*
import arrow.core.raise.either
import arrow.core.raise.zipOrAccumulate
import ia.felles.definisjoner.bransjer.Bransjer
import io.ktor.http.*
import io.ktor.server.request.*
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.ANTALL_DAGER_FØR_SAK_LÅSES
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraværsstatistikk.api.Sykefraværsprosent.Companion.tilSykefraværsProsent
import no.nav.lydia.sykefraværsstatistikk.api.geografi.GeografiService
import no.nav.lydia.sykefraværsstatistikk.import.Kvartal
import no.nav.lydia.tilgangskontroll.NavAnsatt
import no.nav.lydia.tilgangskontroll.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import no.nav.lydia.virksomhet.domene.Sektor
import no.nav.lydia.virksomhet.domene.tilSektor
import java.time.LocalDate
import java.time.LocalDateTime

data class Søkeparametere(
    val kommunenummer: Set<String>,
    val næringsgruppeKoder: Set<String>,
    val sorteringsnøkkel: Sorteringsnøkkel,
    val sorteringsretning: Sorteringsretning,
    val sykefraværsprosentFra: Sykefraværsprosent?,
    val sykefraværsprosentTil: Sykefraværsprosent?,
    val snittFilter: SnittFilter?,
    val ansatteFra: Int?,
    val ansatteTil: Int?,
    val status: IAProsessStatus?,
    val side: Int,
    val navIdenter: Set<String>,
    val bransjeprogram: Set<Bransjer>,
    val sektor: Set<Sektor>,
) {
    fun toLogString() = "Søk med parametere:" +
            (sykefraværsprosentFra?.let { " $SYKEFRAVÆRSPROSENT_FRA=$sykefraværsprosentFra" } ?: "") +
            (sykefraværsprosentTil?.let { " $SYKEFRAVÆRSPROSENT_TIL=$sykefraværsprosentTil" } ?: "") +
            (ansatteFra?.let { " $ANSATTE_FRA=$ansatteFra" } ?: "") +
            (ansatteTil?.let { " $ANSATTE_TIL=$ansatteTil" } ?: "") +
            (if (kommunenummer.isNotEmpty()) " $KOMMUNER=$kommunenummer" else "") +
            (if (næringsgruppeKoder.isNotEmpty()) " $NÆRINGSGRUPPER=$næringsgruppeKoder" else "") +
            (if (navIdenter.isNotEmpty()) " $IA_SAK_EIERE=$navIdenter" else "") +
            (status?.let { " $IA_STATUS=$ansatteTil" } ?: "") +
            (if (bransjeprogram.isNotEmpty()) " $BRANSJEPROGRAM=$bransjeprogram" else "") +
            " $SORTERINGSNØKKEL=$sorteringsnøkkel" +
            " $SORTERINGSRETNING=$sorteringsretning" +
            " $SIDE=$side"

    companion object {
        const val VIRKSOMHETER_PER_SIDE = 100

        const val KOMMUNER = "kommuner"
        const val FYLKER = "fylker"
        const val NÆRINGSGRUPPER = "naringsgrupper"
        const val SORTERINGSNØKKEL = "sorteringsnokkel"
        const val SORTERINGSRETNING = "sorteringsretning"
        const val SYKEFRAVÆRSPROSENT_FRA = "sykefravarsprosentFra"
        const val SYKEFRAVÆRSPROSENT_TIL = "sykefravarsprosentTil"
        const val SNITT_FILTER = "snittfilter"
        const val ANSATTE_FRA = "ansatteFra"
        const val ANSATTE_TIL = "ansatteTil"
        const val IA_STATUS = "iaStatus"
        const val SIDE = "side"
        const val BRANSJEPROGRAM = "bransjeprogram"
        const val IA_SAK_EIERE = "eiere"
        const val SEKTOR = "sektor"

        fun ApplicationRequest.søkeparametere(geografiService: GeografiService, navAnsatt: NavAnsatt) =
            either<NonEmptyList<String>, Søkeparametere> {
                zipOrAccumulate(
                    { queryParameters[SYKEFRAVÆRSPROSENT_FRA].tilSykefraværsProsent().bind() },
                    { queryParameters[SYKEFRAVÆRSPROSENT_TIL].tilSykefraværsProsent().bind() },
                    { queryParameters[SIDE].tomSomNull()?.tilValidertHeltall()?.bind() },
                    { queryParameters[ANSATTE_FRA].tomSomNull()?.tilValidertHeltall()?.bind() },
                    { queryParameters[ANSATTE_TIL].tomSomNull()?.tilValidertHeltall()?.bind() }
                ) { sykefraværsProsentFra, sykefraværsProsentTil, side, ansatteFra, ansatteTil ->
                    Søkeparametere(
                        sykefraværsprosentFra = sykefraværsProsentFra,
                        sykefraværsprosentTil = sykefraværsProsentTil,
                        snittFilter = queryParameters[SNITT_FILTER].tomSomNull()?.let { SnittFilter.valueOf(it) },
                        side = side ?: 1,
                        ansatteFra = ansatteFra,
                        ansatteTil = ansatteTil,
                        kommunenummer = finnGyldigeKommunenummer(queryParameters, geografiService),
                        næringsgruppeKoder = finnGyldigeNæringsgruppekoder(queryParameters),
                        sorteringsnøkkel = Sorteringsnøkkel.from(queryParameters[SORTERINGSNØKKEL]),
                        sorteringsretning = Sorteringsretning.from(queryParameters[SORTERINGSRETNING]),
                        status = queryParameters[IA_STATUS].tomSomNull()?.let { IAProsessStatus.valueOf(it) },
                        navIdenter = navIdenter(navAnsatt = navAnsatt),
                        bransjeprogram = finnBransjeProgram(queryParameters[BRANSJEPROGRAM]),
                        sektor = finnSektor(queryParameters[SEKTOR])
                    )
                }
            }.mapLeft {
                Feil(it.joinToString(separator = "\n"), HttpStatusCode.BadRequest)
            }

        fun filtrerPåSektor(søkeparametere: Søkeparametere) =
            if(søkeparametere.sektor.isEmpty()) ""
            else " AND sektor in (select unnest(:sektorer)) "

        fun filtrerPåEiere(søkeparametere: Søkeparametere) =
            if (søkeparametere.navIdenter.isEmpty()) ""
            else " AND ia_sak.eid_av in (select unnest(:eiere)) "

        fun filtrerPåStatus(søkeparametere: Søkeparametere) =
            søkeparametere.status?.let { status ->
                when (status) {
                    IAProsessStatus.IKKE_AKTIV -> " AND (ia_sak.status IS NULL " +
                            "OR ((ia_sak.status = 'IKKE_AKTUELL' OR ia_sak.status = 'FULLFØRT' OR ia_sak.status = 'SLETTET') " +
                            "AND ia_sak.endret < '${LocalDate.now().minusDays(ANTALL_DAGER_FØR_SAK_LÅSES)}'))"

                    IAProsessStatus.IKKE_AKTUELL, IAProsessStatus.FULLFØRT, IAProsessStatus.SLETTET ->
                        " AND ia_sak.status = '$status' " +
                                "AND ia_sak.endret >= '${LocalDate.now().minusDays(ANTALL_DAGER_FØR_SAK_LÅSES)}'"

                    else -> " AND ia_sak.status = '$status'"
                }
            } ?: ""

        fun filtrerPåKommuner(søkeparametere: Søkeparametere) =
            if (søkeparametere.kommunenummer.isEmpty()) ""
            else " AND kommunenummer in (select unnest(:kommuner)) "

        fun filtrerPåSnitt(søkeparametere: Søkeparametere) =
                søkeparametere.snittFilter?.let { snittFilter ->
                        """
                            AND (
                              (statistikk.bransje_prosent is null AND statistikk.prosent ${snittFilterTilSammenligningstegn(snittFilter)} statistikk.naring_prosent) 
                                OR 
                              (statistikk.bransje_prosent is not null AND statistikk.prosent ${snittFilterTilSammenligningstegn(snittFilter)} statistikk.bransje_prosent)
                            ) 
                        """.trimIndent()
                } ?: ""

        private fun snittFilterTilSammenligningstegn(snittFilter: SnittFilter) =
            when (snittFilter) {
                SnittFilter.BRANSJE_NÆRING_OVER -> ">"
                SnittFilter.BRANSJE_NÆRING_UNDER_ELLER_LIK -> "<="
            }

        fun joinTilNæringEllerBransje(søkeparametere: Søkeparametere) =
            if (søkeparametere.snittFilter == SnittFilter.BRANSJE_NÆRING_OVER
                || søkeparametere.snittFilter == SnittFilter.BRANSJE_NÆRING_UNDER_ELLER_LIK) {"""
              LEFT JOIN naringsundergrupper_per_bransje AS bransjeprogram on (vn.naringsundergruppe1 = bransjeprogram.naringsundergruppe)
              LEFT JOIN sykefravar_statistikk_kategori_siste_4_kvartal AS bransje_siste4
                ON (bransjeprogram.bransje = bransje_siste4.kode
                    AND bransje_siste4.kategori = 'BRANSJE'
                    AND bransje_siste4.publisert_kvartal = statistikk.kvartal
                    AND bransje_siste4.publisert_arstall = statistikk.arstall)
              JOIN sykefravar_statistikk_kategori_siste_4_kvartal AS naring_siste4
                ON (substr(vn.naringsundergruppe1, 1, 2) = naring_siste4.kode
                    AND naring_siste4.kategori = 'NÆRING'
                    AND naring_siste4.publisert_kvartal = statistikk.kvartal
                    AND naring_siste4.publisert_arstall = statistikk.arstall)
            """.trimIndent()
            } else ""

        fun filtrerPåBransjeOgNæring(søkeparametere: Søkeparametere): String {
            val næringsgrupperMedBransjer = søkeparametere.næringsgrupperMedBransjer()
            return if (næringsgrupperMedBransjer.isEmpty())
                ""
            else
                """
                AND (
                   substr(naringsundergruppe1, 1, 2) in (select unnest(:naringer)) 
                   OR substr(naringsundergruppe2, 1, 2) in (select unnest(:naringer)) 
                   OR substr(naringsundergruppe3, 1, 2) in (select unnest(:naringer))
                    ${
                    if (søkeparametere.bransjeprogram.isNotEmpty()) {
                        val koder = søkeparametere.bransjeprogram.flatMap { it.næringskoder }.groupBy {
                            it.length
                        }
                        val femsifrede = koder[5]?.joinToString { "'${it.take(2)}.${it.takeLast(3)}'" }
                        femsifrede?.let { 
                            "OR (naringsundergruppe1 in (select (unnest(:naringer))))" + 
                            "OR (naringsundergruppe2 in (select (unnest(:naringer))))" +
                            "OR (naringsundergruppe3 in (select (unnest(:naringer))))" 
                        } ?: ""
                    } else ""
                }
                    )
            """.trimIndent()
        }

        private fun ApplicationRequest.navIdenter(navAnsatt: NavAnsatt): Set<String> {
            return queryParameters[IA_SAK_EIERE].tilUnikeVerdier().let { eiere ->
                when (navAnsatt) {
                    is Superbruker -> eiere.toSet()
                    else -> eiere.filter { it == navAnsatt.navIdent }.toSet()
                }
            }
        }

        private fun finnSektor(queryParams: String?): Set<Sektor> =
            queryParams.tomSomNull()?.tilUnikeVerdier()?.map { it.tilSektor() }?.requireNoNulls()?.toSet() ?: emptySet()

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

data class Periode(val kvartal: Int, val årstall: Int) {
    companion object {
        fun fraDato(dato: LocalDateTime) = Periode(årstall = dato.year, kvartal = dato.monthValue / 4 + 1).forrigePeriode()
    }

    fun tilKvartal() = Kvartal(årstall = årstall, kvartal = kvartal)

    fun forrigePeriode() =
        when (this.kvartal) {
            1 -> Periode(kvartal = 4, årstall = this.årstall - 1)
            else -> Periode(kvartal = this.kvartal - 1, årstall = this.årstall)
        }

    operator fun compareTo(annen: Periode): Int {
        if (årstall.compareTo(annen.årstall) == 0) {
            return kvartal.compareTo(annen.kvartal)
        }
        return årstall.compareTo(annen.årstall)
    }
}

enum class Sorteringsnøkkel(val verdi: String) {
    NAVN_PÅ_VIRKSOMHET("navn"),
    TAPTE_DAGSVERK("tapte_dagsverk"),
    ANTALL_PERSONER("antall_personer"),
    MULIGE_DAGSVERK("mulige_dagsverk"),
    SYKEFRAVÆRSPROSENT("sykefravarsprosent"),
    SIST_ENDRET("sist_endret");

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
        fun String?.tilSykefraværsProsent(): Either<String, Sykefraværsprosent?> =
            tomSomNull()?.tilValidertFlyttall()?.flatMap { it.tilSykefraværsProsent() } ?: Either.Right(null)

        fun Double.tilSykefraværsProsent(): Either<String, Sykefraværsprosent> =
            if (this.isFinite() && (0.0..100.0).contains(this))
                Sykefraværsprosent(this).right()
            else
                "$this er ikke en gyldig sykefraværsprosent. Sykefraværsprosent er forventet å være '0.0 >= prosent <= 100.0'".left()
    }

    override fun toString() = sykefraværsProsent.toString()
}

private fun String.tilValidertFlyttall() = try {
    this.toDouble().right()
} catch (e: Exception) {
    "$this er ikke et gyldig flyttall".left()
}

private fun String.tilValidertHeltall() = try {
    this.toInt().right()
} catch (e: Exception) {
    "$this er ikke et gyldig heltall".left()
}

private fun String?.tomSomNull() = this?.ifBlank { null }
