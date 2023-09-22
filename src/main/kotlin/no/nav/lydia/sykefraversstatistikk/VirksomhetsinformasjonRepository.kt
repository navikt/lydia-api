package no.nav.lydia.sykefraversstatistikk

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import kotlinx.datetime.toKotlinLocalDate
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.sykefraversstatistikk.api.Sorteringsnøkkel
import no.nav.lydia.sykefraversstatistikk.api.Sorteringsnøkkel.ANTALL_PERSONER
import no.nav.lydia.sykefraversstatistikk.api.Sorteringsnøkkel.MULIGE_DAGSVERK
import no.nav.lydia.sykefraversstatistikk.api.Sorteringsnøkkel.NAVN_PÅ_VIRKSOMHET
import no.nav.lydia.sykefraversstatistikk.api.Sorteringsnøkkel.SIST_ENDRET
import no.nav.lydia.sykefraversstatistikk.api.Sorteringsnøkkel.SYKEFRAVÆRSPROSENT
import no.nav.lydia.sykefraversstatistikk.api.Sorteringsnøkkel.TAPTE_DAGSVERK
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåBransjeOgNæring
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåEiere
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåKommuner
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåSektor
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåSnitt
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåStatus
import no.nav.lydia.sykefraversstatistikk.domene.Virksomhetsoversikt
import no.nav.lydia.sykefraversstatistikk.domene.VirksomhetsstatistikkSiste4Kvartal
import no.nav.lydia.sykefraversstatistikk.domene.VirksomhetsstatistikkSisteKvartal
import no.nav.lydia.sykefraversstatistikk.import.Kvartal
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

    fun hentVirksomhetsstatistikkSiste4Kvartal(orgnr: String): VirksomhetsstatistikkSiste4Kvartal? {
        return using(sessionOf(dataSource)) { session ->
            val query = queryOf(
                statement = """
                    SELECT
                        orgnr,
                        tapte_dagsverk,
                        mulige_dagsverk,
                        prosent,
                        maskert,
                        antall_kvartaler,
                        sist_endret,
                        kvartaler
                  FROM sykefravar_statistikk_virksomhet_siste_4_kvartal
                  WHERE (orgnr = :orgnr)
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
                        orgnr,
                        arstall,
                        kvartal,
                        antall_personer,
                        tapte_dagsverk,
                        mulige_dagsverk,
                        sykefraversprosent,
                        maskert
                  FROM sykefravar_statistikk_virksomhet
                  WHERE (orgnr = :orgnr)
                  ${
                      periode?.let { """
                          AND kvartal = ${it.kvartal}
                          AND arstall = ${it.årstall}
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

    private fun mapRowToSisteKvartal(row: Row) = VirksomhetsstatistikkSisteKvartal(
        orgnr = row.string("orgnr"),
        arstall = row.int("arstall"),
        kvartal = row.int("kvartal"),
        antallPersoner = row.double("antall_personer"),
        tapteDagsverk = row.double("tapte_dagsverk"),
        muligeDagsverk = row.double("mulige_dagsverk"),
        sykefraversprosent = row.double("sykefraversprosent"),
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
            muligeDagsverk = row.doubleOrNull("mulige_dagsverk") ?: 0.0,
            sykefraversprosent = row.doubleOrNull("prosent") ?: 0.0,
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
