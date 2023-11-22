package no.nav.lydia.sykefraværsstatistikk

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import ia.felles.definisjoner.bransjer.Bransjer
import kotlinx.datetime.toKotlinLocalDate
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraværsstatistikk.api.Periode
import no.nav.lydia.sykefraværsstatistikk.api.Sorteringsnøkkel
import no.nav.lydia.sykefraværsstatistikk.api.Sorteringsnøkkel.ANTALL_PERSONER
import no.nav.lydia.sykefraværsstatistikk.api.Sorteringsnøkkel.MULIGE_DAGSVERK
import no.nav.lydia.sykefraværsstatistikk.api.Sorteringsnøkkel.NAVN_PÅ_VIRKSOMHET
import no.nav.lydia.sykefraværsstatistikk.api.Sorteringsnøkkel.SIST_ENDRET
import no.nav.lydia.sykefraværsstatistikk.api.Sorteringsnøkkel.SYKEFRAVÆRSPROSENT
import no.nav.lydia.sykefraværsstatistikk.api.Sorteringsnøkkel.TAPTE_DAGSVERK
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.filtrerPåBransjeOgNæring
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.filtrerPåEiere
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.filtrerPåKommuner
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.filtrerPåSektor
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.filtrerPåSnitt
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.filtrerPåStatus
import no.nav.lydia.sykefraværsstatistikk.domene.Statistikkdata
import no.nav.lydia.sykefraværsstatistikk.domene.Virksomhetsoversikt
import no.nav.lydia.sykefraværsstatistikk.domene.VirksomhetsstatistikkSiste4Kvartal
import no.nav.lydia.sykefraværsstatistikk.domene.VirksomhetsstatistikkSisteKvartal
import no.nav.lydia.sykefraværsstatistikk.import.Kategori
import no.nav.lydia.sykefraværsstatistikk.import.Kvartal
import no.nav.lydia.virksomhet.domene.Sektor
import javax.sql.DataSource

class VirksomhetsinformasjonRepository(val dataSource: DataSource) {
    private val gson: Gson = GsonBuilder().create()

    fun søkEtterVirksomheter(
        søkeparametere: Søkeparametere,
    ) = using(sessionOf(dataSource)) { session ->
        val næringsgrupperMedBransjer = søkeparametere.næringsgrupperMedBransjer()
        val sektorer = søkeparametere.sektor.map { it.kode }.toSet()

        val sql = """
            SELECT
                statistikk.orgnr,
                statistikk.navn,
                statistikk.arstall,
                statistikk.kvartal,
                statistikk.antall_personer_siste_kvartal AS antall_personer,
                statistikk.tapte_dagsverk,
                statistikk.mulige_dagsverk,
                statistikk.prosent,
                statistikk.maskert,
                ia_sak.status,
                ia_sak.eid_av,
                ia_sak.endret
            FROM
                virksomhetsstatistikk_for_prioritering AS statistikk
                LEFT JOIN ia_sak ON (
                    (ia_sak.orgnr = statistikk.orgnr) AND
                    ia_sak.endret = (select max(endret) from ia_sak iasak2 where iasak2.orgnr = statistikk.orgnr)
                )
            WHERE true = true
                
                ${filtrerPåBransjeOgNæring(søkeparametere = søkeparametere)}
                ${filtrerPåKommuner(søkeparametere = søkeparametere)}
                ${filtrerPåStatus(søkeparametere = søkeparametere)}
                ${filtrerPåSektor(søkeparametere = søkeparametere)}
                ${filtrerPåEiere(søkeparametere = søkeparametere)}
                ${filtrerPåSnitt(søkeparametere = søkeparametere)}
                
                ${søkeparametere.sykefraværsprosentFra?.let { " AND prosent >= $it " } ?: ""}
                ${søkeparametere.sykefraværsprosentTil?.let { " AND prosent <= $it " } ?: ""}
                ${søkeparametere.ansatteFra?.let { " AND antall_personer_siste_kvartal >= $it " } ?: ""}
                ${søkeparametere.ansatteTil?.let { " AND antall_personer_siste_kvartal <= $it " } ?: ""}
            ${søkeparametere.sorteringsnøkkel.tilOrderBy()} ${søkeparametere.sorteringsretning} NULLS LAST
            LIMIT ${søkeparametere.virksomheterPerSide()}
            OFFSET ${søkeparametere.offset()}
        """.trimIndent()

        val query = queryOf(
            statement = sql,
            mapOf(
                "naringer" to session.createArrayOf("text", næringsgrupperMedBransjer),
                "kommuner" to session.createArrayOf("text", søkeparametere.kommunenummer),
                "sektorer" to session.createArrayOf("text", sektorer),
                "eiere" to session.createArrayOf("text", søkeparametere.navIdenter),
            )
        ).map(this::mapRowToOversikt).asList
        session.run(query)
    }

    fun hentTotaltAntallVirksomheter(søkeparametere: Søkeparametere): Int? = using(sessionOf(dataSource)) { session ->
        val næringsgrupperMedBransjer = søkeparametere.næringsgrupperMedBransjer()
        val sektorer = søkeparametere.sektor.map { it.kode }.toSet()

        val sql = """
            SELECT
                COUNT(statistikk.orgnr) AS total
            FROM
                virksomhetsstatistikk_for_prioritering AS statistikk
                LEFT JOIN ia_sak ON (
                    (ia_sak.orgnr = statistikk.orgnr) AND
                    ia_sak.endret = (select max(endret) from ia_sak iasak2 where iasak2.orgnr = statistikk.orgnr)
                )
            WHERE true = true
                ${filtrerPåBransjeOgNæring(søkeparametere = søkeparametere)}
                ${filtrerPåKommuner(søkeparametere = søkeparametere)}
                ${filtrerPåStatus(søkeparametere = søkeparametere)}
                ${filtrerPåSektor(søkeparametere = søkeparametere)}
                ${filtrerPåEiere(søkeparametere = søkeparametere)}
                
                ${søkeparametere.sykefraværsprosentFra?.let { " AND prosent >= $it " } ?: ""}
                ${søkeparametere.sykefraværsprosentTil?.let { " AND prosent <= $it " } ?: ""}
                ${filtrerPåSnitt(søkeparametere = søkeparametere)}
                ${søkeparametere.ansatteFra?.let { " AND antall_personer_siste_kvartal >= $it " } ?: ""}
                ${søkeparametere.ansatteTil?.let { " AND antall_personer_siste_kvartal <= $it " } ?: ""}
        """.trimIndent()

        val query = queryOf(
            statement = sql,
            mapOf(
                "naringer" to session.createArrayOf("text", næringsgrupperMedBransjer),
                "kommuner" to session.createArrayOf("text", søkeparametere.kommunenummer),
                "sektorer" to session.createArrayOf("text", sektorer),
                "eiere" to session.createArrayOf("text", søkeparametere.navIdenter),
            )
        )
        session.run(query.map { it.int("total") }.asSingle)
    }

    fun hentVirksomhetsstatistikkSiste4Kvartal(orgnr: String, periode: Periode): VirksomhetsstatistikkSiste4Kvartal? {
        return using(sessionOf(dataSource)) { session ->
            val query = queryOf(
                statement = """
                      SELECT
                          sykefravar_statistikk_virksomhet_siste_4_kvartal.orgnr,
                          sykefravar_statistikk_virksomhet_siste_4_kvartal.tapte_dagsverk,
                          sykefravar_statistikk_virksomhet_gradering_siste_4_kvartal.tapte_dagsverk_gradert,
                          sykefravar_statistikk_virksomhet_siste_4_kvartal.mulige_dagsverk,
                          sykefravar_statistikk_virksomhet_siste_4_kvartal.prosent,
                          sykefravar_statistikk_virksomhet_gradering_siste_4_kvartal.prosent as graderingsprosent,
                          sykefravar_statistikk_virksomhet_siste_4_kvartal.maskert,
                          sykefravar_statistikk_virksomhet_siste_4_kvartal.antall_kvartaler,
                          sykefravar_statistikk_virksomhet_siste_4_kvartal.sist_endret,
                          sykefravar_statistikk_virksomhet_siste_4_kvartal.kvartaler
                    FROM sykefravar_statistikk_virksomhet_siste_4_kvartal
                    LEFT JOIN sykefravar_statistikk_virksomhet_gradering_siste_4_kvartal 
                      ON (
                      sykefravar_statistikk_virksomhet_siste_4_kvartal.orgnr = sykefravar_statistikk_virksomhet_gradering_siste_4_kvartal.orgnr
                         AND sykefravar_statistikk_virksomhet_siste_4_kvartal.publisert_kvartal = sykefravar_statistikk_virksomhet_gradering_siste_4_kvartal.publisert_kvartal
                         AND sykefravar_statistikk_virksomhet_siste_4_kvartal.publisert_arstall = sykefravar_statistikk_virksomhet_gradering_siste_4_kvartal.publisert_arstall
                      )
                    WHERE (sykefravar_statistikk_virksomhet_siste_4_kvartal.orgnr = :orgnr)
                         AND sykefravar_statistikk_virksomhet_siste_4_kvartal.publisert_kvartal = ${periode.kvartal}
                         AND sykefravar_statistikk_virksomhet_siste_4_kvartal.publisert_arstall = ${periode.årstall}
                  
                """.trimIndent(), paramMap = mapOf(
                    "orgnr" to orgnr
                )
            ).map(this::mapRowToSiste4Kvartal).asSingle
            session.run(query)
        }
    }

    fun hentVirksomhetsstatistikkSisteKvartal(orgnr: String, periode: Periode? = null) =
        using(sessionOf(dataSource)) { session ->
            val query = queryOf(
                statement = """
                      SELECT
                          sykefravar_statistikk_virksomhet.orgnr,
                          sykefravar_statistikk_virksomhet.arstall,
                          sykefravar_statistikk_virksomhet.kvartal,
                          sykefravar_statistikk_virksomhet.antall_personer,
                          sykefravar_statistikk_virksomhet_gradering.tapte_dagsverk_gradert,
                          sykefravar_statistikk_virksomhet.tapte_dagsverk,
                          sykefravar_statistikk_virksomhet.mulige_dagsverk,
                          sykefravar_statistikk_virksomhet.sykefraversprosent,
                          sykefravar_statistikk_virksomhet_gradering.prosent as graderingsprosent,
                          sykefravar_statistikk_virksomhet.maskert
                    FROM sykefravar_statistikk_virksomhet 
                    LEFT JOIN sykefravar_statistikk_virksomhet_gradering
                    ON (
                      sykefravar_statistikk_virksomhet.orgnr = sykefravar_statistikk_virksomhet_gradering.orgnr
                         AND sykefravar_statistikk_virksomhet.kvartal = sykefravar_statistikk_virksomhet_gradering.kvartal
                         AND sykefravar_statistikk_virksomhet.arstall = sykefravar_statistikk_virksomhet_gradering.arstall
                      )
                    WHERE (sykefravar_statistikk_virksomhet.orgnr = :orgnr)
                  ${
                      periode?.let { """
                          AND sykefravar_statistikk_virksomhet.kvartal = ${it.kvartal}
                          AND sykefravar_statistikk_virksomhet.arstall = ${it.årstall}
                      """.trimIndent() } ?: ""
                  }
                  ORDER BY arstall DESC, kvartal DESC
                  LIMIT 1
                """.trimIndent(),
                paramMap = mapOf(
                    "orgnr" to orgnr
                )
            ).map { mapRowToSisteKvartal(it) }.asSingle
            session.run(query)
        }


    fun hentNæringstatistikkPerKvartal(næring: String) =
        hentKategoristatistikkPerKvartal(Kategori.NÆRING, næring)

    fun hentBransjestatistikkPerKvartal(bransje: Bransjer) =
        hentKategoristatistikkPerKvartal(Kategori.BRANSJE, bransje.name)

    fun hentSektorstatistikkPerKvartal(sektor: Sektor) =
        hentKategoristatistikkPerKvartal(Kategori.SEKTOR, sektor.kode)

    fun hentLandsstatistikkPerKvartal() =
        hentKategoristatistikkPerKvartal(Kategori.LAND, LANDKODE_NO)

    private fun hentKategoristatistikkPerKvartal(kategori: Kategori, kode: String) =
        using(sessionOf(dataSource)) { session ->
            val query = queryOf(
                statement = """
                    SELECT
                        ${kategori.kodenavn()},
                        arstall,
                        kvartal,
                        prosent,
                        maskert
                  FROM ${kategori.tabellnavn()}
                  WHERE ${kategori.kodenavn()} = :kode
                  ORDER BY arstall DESC, kvartal DESC
                """.trimIndent(),
                paramMap = mapOf(
                    "kode" to kode
                )
            ).map { mapKategoriRowToStatistikkdata(it) }.asList
            session.run(query)
        }

    fun hentVirksomhetsstatistikkPerKvartal(orgnr: String) =
            using(sessionOf(dataSource)) { session ->
                val query = queryOf(
                        statement = """
                    SELECT
                        orgnr,
                        arstall,
                        kvartal,
                        sykefraversprosent,
                        maskert
                  FROM sykefravar_statistikk_virksomhet
                  WHERE (orgnr = :orgnr)
                  ORDER BY arstall DESC, kvartal DESC
                """.trimIndent(),
                        paramMap = mapOf(
                                "orgnr" to orgnr
                        )
                ).map { mapVirksomhetRowToStatistikkdata(it) }.asList
                session.run(query)
            }

    private fun mapKategoriRowToStatistikkdata(row: Row) = Statistikkdata(
        årstall = row.int("arstall"),
        kvartal = row.int("kvartal"),
        sykefraværsprosent = row.double("prosent"),
        maskert = row.boolean("maskert"),
    )

    private fun mapVirksomhetRowToStatistikkdata(row: Row) = Statistikkdata(
            årstall = row.int("arstall"),
            kvartal = row.int("kvartal"),
            sykefraværsprosent = row.double("sykefraversprosent"),
            maskert = row.boolean("maskert"),
    )

    private fun mapRowToSisteKvartal(row: Row) = VirksomhetsstatistikkSisteKvartal(
        orgnr = row.string("orgnr"),
        arstall = row.int("arstall"),
        kvartal = row.int("kvartal"),
        antallPersoner = row.double("antall_personer"),
        tapteDagsverkGradert = row.doubleOrNull("tapte_dagsverk_gradert"),
        tapteDagsverk = row.double("tapte_dagsverk"),
        muligeDagsverk = row.double("mulige_dagsverk"),
        sykefraversprosent = row.double("sykefraversprosent"),
        graderingsprosent = row.doubleOrNull("graderingsprosent"),
        maskert = row.boolean("maskert"),
    )

    private fun mapRowToOversikt(row: Row): Virksomhetsoversikt {
        return Virksomhetsoversikt(
            virksomhetsnavn = row.string("navn"),
            orgnr = row.string("orgnr"),
            arstall = row.int("arstall"),
            kvartal = row.int("kvartal"),
            antallPersoner = row.double("antall_personer"),
            tapteDagsverk = row.doubleOrNull("tapte_dagsverk") ?: 0.0,
            muligeDagsverk = row.doubleOrNull("mulige_dagsverk") ?: 0.0,
            sykefraversprosent = row.doubleOrNull("prosent") ?: 0.0,
            maskert = row.boolean("maskert"),
            status = row.stringOrNull("status")?.let {
                IAProsessStatus.valueOf(it)
            },
            eidAv = row.stringOrNull("eid_av"),
            sistEndret = row.localDateOrNull("endret")?.toKotlinLocalDate()
        )
    }

    private fun mapRowToSiste4Kvartal(row: Row): VirksomhetsstatistikkSiste4Kvartal {
        val kvartalListeType = object : TypeToken<List<Kvartal>>() {}.type
        return VirksomhetsstatistikkSiste4Kvartal(
            orgnr = row.string("orgnr"),
            tapteDagsverk = row.doubleOrNull("tapte_dagsverk") ?: 0.0,
            tapteDagsverkGradert = row.doubleOrNull("tapte_dagsverk_gradert"),
            muligeDagsverk = row.doubleOrNull("mulige_dagsverk") ?: 0.0,
            sykefraversprosent = row.doubleOrNull("prosent") ?: 0.0,
            graderingsprosent = row.doubleOrNull("graderingsprosent"),
            maskert = row.boolean("maskert"),
            opprettet = row.localDateTime("sist_endret"),
            antallKvartaler = row.int("antall_kvartaler"),
            kvartaler = gson.fromJson(row.string("kvartaler"), kvartalListeType),
        )
    }

    private fun Sorteringsnøkkel.tilOrderBy(): String {
        return when (this) {
            NAVN_PÅ_VIRKSOMHET -> "ORDER BY navn"
            ANTALL_PERSONER -> "ORDER BY antall_personer"
            SYKEFRAVÆRSPROSENT -> "ORDER BY prosent"
            TAPTE_DAGSVERK -> "ORDER BY tapte_dagsverk"
            MULIGE_DAGSVERK -> "ORDER BY mulige_dagsverk"
            SIST_ENDRET -> "ORDER BY endret"
        }
    }
}
