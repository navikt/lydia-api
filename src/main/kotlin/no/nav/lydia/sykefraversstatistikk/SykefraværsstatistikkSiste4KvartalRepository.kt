package no.nav.lydia.sykefraversstatistikk

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import kotlinx.datetime.toKotlinLocalDate
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.ANTALL_DAGER_FØR_SAK_LÅSES
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.Sorteringsnøkkel
import no.nav.lydia.sykefraversstatistikk.api.Sorteringsnøkkel.*
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkForVirksomhetSiste4Kvartaler
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet
import no.nav.lydia.sykefraversstatistikk.import.Kvartal
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import java.time.LocalDate
import javax.sql.DataSource

class SykefraværsstatistikkSiste4KvartalRepository(val dataSource: DataSource) {
    private val gson: Gson = GsonBuilder().create()
    fun hentSykefravær(
        søkeparametere: Søkeparametere,
    ) = using(sessionOf(dataSource)) { session ->
        val næringsgrupperMedBransjer = søkeparametere.næringsgrupperMedBransjer()
        val sektorer = søkeparametere.sektor.map { it.kode }.toSet()
        val tmpKommuneTabell = "kommuner"
        val tmpNæringTabell = "naringer"
        val tmpNavIdenterTabell = "nav_identer"
        val tmpSektorTabell = "sektorer"
        val sql = """
                    WITH 
                        ${filterVerdi(tmpKommuneTabell, søkeparametere.kommunenummer)},
                        ${filterVerdi(tmpNæringTabell, næringsgrupperMedBransjer)},
                        ${filterVerdi(tmpNavIdenterTabell, søkeparametere.navIdenter)},
                        ${filterVerdi(tmpSektorTabell, sektorer)}
                    SELECT
                        virksomhet.orgnr,
                        virksomhet.navn,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        statistikk.arstall,
                        statistikk.kvartal,
                        statistikk.antall_personer,
                        statistikk_siste4.tapte_dagsverk,
                        statistikk_siste4.mulige_dagsverk,
                        statistikk_siste4.prosent,
                        statistikk_siste4.maskert,
                        statistikk_siste4.sist_endret,
                        ia_sak.status,
                        ia_sak.eid_av,
                        ia_sak.endret
                    ${
            filter(
                tmpKommuneTabell = tmpKommuneTabell,
                tmpNavIdenterTabell = tmpNavIdenterTabell,
                tmpNæringTabell = tmpNæringTabell,
                tmpSektorTabell = tmpSektorTabell,
                søkeparametere = søkeparametere
            )
        }
                    GROUP BY 
                        virksomhet.orgnr,
                        virksomhet.navn,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        statistikk.arstall,
                        statistikk.kvartal,
                        statistikk.antall_personer,
                        statistikk_siste4.tapte_dagsverk,
                        statistikk_siste4.mulige_dagsverk,
                        statistikk_siste4.prosent,
                        statistikk_siste4.maskert,
                        statistikk_siste4.sist_endret,
                        ia_sak.status,
                        ia_sak.eid_av,
                        ia_sak.endret
                    ${søkeparametere.sorteringsnøkkel.tilOrderBy()} ${søkeparametere.sorteringsretning} NULLS LAST
                    LIMIT ${søkeparametere.virksomheterPerSide()}
                    OFFSET ${søkeparametere.offset()}
                """.trimIndent()

        val query = queryOf(
            statement = sql, mapOf(
                tmpKommuneTabell to session.connection.underlying.createArrayOf(
                    "text", søkeparametere.kommunenummer.toTypedArray()
                ),
                tmpNæringTabell to session.connection.underlying.createArrayOf(
                    "text", næringsgrupperMedBransjer.toTypedArray()
                ),
                tmpNavIdenterTabell to session.connection.underlying.createArrayOf(
                    "text", søkeparametere.navIdenter.toTypedArray()
                ),
                tmpSektorTabell to session.connection.underlying.createArrayOf(
                    "text", sektorer.toTypedArray()
                ),
                "kvartal" to søkeparametere.periode.kvartal, "arstall" to søkeparametere.periode.årstall
            )
        ).map(this::mapRow).asList
        session.run(query)
    }

    private fun Sorteringsnøkkel.tilOrderBy(): String {
        return when (this) {
            NAVN_PÅ_VIRKSOMHET -> "ORDER BY virksomhet.navn"
            ANTALL_PERSONER -> "ORDER BY statistikk.antall_personer"
            SYKEFRAVÆRSPROSENT -> "ORDER BY statistikk_siste4.prosent"
            TAPTE_DAGSVERK -> "ORDER BY statistikk_siste4.tapte_dagsverk"
            MULIGE_DAGSVERK -> "ORDER BY statistikk_siste4.mulige_dagsverk"
        }
    }

    fun hentTotaltAntall(søkeparametere: Søkeparametere): Int? = using(sessionOf(dataSource)) { session ->
        val næringsgrupperMedBransjer = søkeparametere.næringsgrupperMedBransjer()
        val sektorer = søkeparametere.sektor.map { it.kode }.toSet()
        val tmpKommuneTabell = "kommuner"
        val tmpNæringTabell = "naringer"
        val tmpNavIdenterTabell = "nav_identer"
        val tmpSektorTabell = "sektorer"
        val sql = """
                        WITH 
                            ${filterVerdi(tmpKommuneTabell, søkeparametere.kommunenummer)},
                            ${filterVerdi(tmpNæringTabell, næringsgrupperMedBransjer)},
                            ${filterVerdi(tmpNavIdenterTabell, søkeparametere.navIdenter)},
                            ${filterVerdi(tmpSektorTabell, sektorer)}
                        SELECT
                            COUNT(DISTINCT virksomhet.orgnr) AS total
                        ${
            filter(
                tmpKommuneTabell = tmpKommuneTabell,
                tmpNavIdenterTabell = tmpNavIdenterTabell,
                tmpNæringTabell = tmpNæringTabell,
                tmpSektorTabell = tmpSektorTabell,
                søkeparametere = søkeparametere
            )
        }
                    """.trimIndent()

        val query = queryOf(
            statement = sql, mapOf(
                tmpKommuneTabell to session.connection.underlying.createArrayOf(
                    "text", søkeparametere.kommunenummer.toTypedArray()
                ),
                tmpNæringTabell to session.connection.underlying.createArrayOf(
                    "text", næringsgrupperMedBransjer.toTypedArray()
                ),
                tmpNavIdenterTabell to session.connection.underlying.createArrayOf(
                    "text", søkeparametere.navIdenter.toTypedArray()
                ),
                tmpSektorTabell to session.connection.underlying.createArrayOf(
                    "text", sektorer.toTypedArray()
                ),
                "kvartal" to søkeparametere.periode.kvartal, "arstall" to søkeparametere.periode.årstall
            )
        )
        session.run(query.map { it.int("total") }.asSingle)
    }

    private fun filter(
        tmpKommuneTabell: String,
        tmpNavIdenterTabell: String,
        tmpNæringTabell: String,
        tmpSektorTabell: String,
        søkeparametere: Søkeparametere,
    ) = """
        FROM sykefravar_statistikk_virksomhet AS statistikk
        JOIN virksomhet USING (orgnr)
        LEFT JOIN sykefravar_statistikk_virksomhet_siste_4_kvartal AS statistikk_siste4 USING (orgnr)
        LEFT JOIN virksomhet_statistikk_metadata USING (orgnr)
        LEFT JOIN ia_sak ON (
            (ia_sak.orgnr = statistikk.orgnr) AND
            ia_sak.endret = (select max(endret) from ia_sak iasak2 where iasak2.orgnr = statistikk.orgnr)
        )
        JOIN virksomhet_naring AS vn on (virksomhet.id = vn.virksomhet)
        
        WHERE (
            (SELECT inkluderAlle FROM $tmpKommuneTabell) IS TRUE OR
            virksomhet.kommunenummer in (select unnest($tmpKommuneTabell.filterverdi) FROM $tmpKommuneTabell)
        )
        AND (
            (SELECT inkluderAlle FROM $tmpNavIdenterTabell) IS TRUE OR
            ia_sak.eid_av in (select unnest($tmpNavIdenterTabell.filterverdi) FROM $tmpNavIdenterTabell)
        )
        AND (
            (SELECT inkluderAlle FROM $tmpSektorTabell) IS TRUE OR
            virksomhet_statistikk_metadata.sektor in (select unnest($tmpSektorTabell.filterverdi) FROM $tmpSektorTabell)
        )
        AND (
            (SELECT inkluderAlle FROM $tmpNæringTabell) IS TRUE
            OR substr(vn.narings_kode, 1, 2) in (select unnest($tmpNæringTabell.filterverdi) FROM $tmpNæringTabell)
            ${
        if (søkeparametere.bransjeprogram.isNotEmpty()) {
            val koder = søkeparametere.bransjeprogram.flatMap { it.næringskoder }.groupBy {
                it.length
            }
            val femsifrede = koder[5]?.joinToString { "'${it.take(2)}.${it.takeLast(3)}'" }
            femsifrede?.let { "OR (vn.narings_kode in (select unnest($tmpNæringTabell.filterverdi) FROM $tmpNæringTabell))" } ?: ""
        } else ""
    }
        )
        AND statistikk.kvartal = :kvartal
        AND statistikk.arstall = :arstall
                        
        ${
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
    }
                        
        ${søkeparametere.sykefraværsprosentFra?.let { " AND statistikk_siste4.prosent >= $it " } ?: ""}
        ${søkeparametere.sykefraværsprosentTil?.let { " AND statistikk_siste4.prosent <= $it " } ?: ""}
        
        ${søkeparametere.ansatteFra?.let { " AND statistikk.antall_personer >= $it " } ?: ""}
        ${søkeparametere.ansatteTil?.let { " AND statistikk.antall_personer <= $it " } ?: ""}
        AND virksomhet.status = '${VirksomhetStatus.AKTIV.name}'
        """.trimIndent()


    fun hentSykefraværForVirksomhet(orgnr: String): List<SykefraversstatistikkVirksomhet> {
        return using(sessionOf(dataSource)) { session ->
            val query = queryOf(
                statement = """
                    SELECT
                        statistikk_siste4.orgnr,
                        virksomhet.navn,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        statistikk.arstall,
                        statistikk.kvartal,
                        statistikk.antall_personer,
                        statistikk_siste4.tapte_dagsverk,
                        statistikk_siste4.mulige_dagsverk,
                        statistikk_siste4.prosent,
                        statistikk_siste4.maskert,
                        statistikk_siste4.sist_endret,
                        ia_sak.status,
                        ia_sak.eid_av,
                        ia_sak.endret
                  FROM sykefravar_statistikk_virksomhet AS statistikk
                  JOIN virksomhet USING (orgnr)
                  LEFT JOIN sykefravar_statistikk_virksomhet_siste_4_kvartal AS statistikk_siste4 USING (orgnr)
                  LEFT JOIN ia_sak USING(orgnr)
                  WHERE (statistikk.orgnr = :orgnr)
                """.trimIndent(), paramMap = mapOf(
                    "orgnr" to orgnr
                )
            ).map(this::mapRow).asList
            session.run(query)
        }
    }

    fun hentSykefraværForVirksomhetSiste4Kvartaler(orgnr: String): List<SykefraversstatistikkForVirksomhetSiste4Kvartaler> {
        return using(sessionOf(dataSource)) { session ->
            val query = queryOf(
                statement = """
                    SELECT
                        statistikk_siste4.orgnr,
                        virksomhet.navn,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        statistikk.arstall,
                        statistikk.kvartal,
                        statistikk.antall_personer,
                        statistikk_siste4.tapte_dagsverk,
                        statistikk_siste4.mulige_dagsverk,
                        statistikk_siste4.prosent,
                        statistikk_siste4.maskert,
                        statistikk_siste4.sist_endret,
                        statistikk_siste4.antall_kvartaler,
                        statistikk_siste4.kvartaler,
                        ia_sak.status,
                        ia_sak.eid_av,
                        ia_sak.endret
                  FROM sykefravar_statistikk_virksomhet AS statistikk
                  JOIN virksomhet USING (orgnr)
                  LEFT JOIN sykefravar_statistikk_virksomhet_siste_4_kvartal AS statistikk_siste4 USING (orgnr)
                  LEFT JOIN ia_sak USING(orgnr)
                  WHERE (statistikk.orgnr = :orgnr)
                """.trimIndent(), paramMap = mapOf(
                    "orgnr" to orgnr
                )
            ).map(this::mapRowTo4Kvaraler).asList
            session.run(query)
        }
    }

    private fun filterVerdi(filterNavn: String, filterVerdier: Set<String>) = """
            $filterNavn (inkluderAlle, filterverdi) AS (
                    VALUES (
                        ${filterVerdier.isEmpty()},
                        :$filterNavn
                    )    
                )
        """.trimIndent()

    private fun mapRow(row: Row): SykefraversstatistikkVirksomhet {
        return SykefraversstatistikkVirksomhet(
            virksomhetsnavn = row.string("navn"),
            kommune = Kommune(row.string("kommune"), row.string("kommunenummer")),
            orgnr = row.string("orgnr"),
            arstall = row.int("arstall"),
            kvartal = row.int("kvartal"),
            antallPersoner = row.double("antall_personer"),
            tapteDagsverk = row.doubleOrNull("tapte_dagsverk") ?: 0.0,
            muligeDagsverk = row.doubleOrNull("mulige_dagsverk") ?: 0.0,
            sykefraversprosent = row.doubleOrNull("prosent") ?: 0.0,
            maskert = row.boolean("maskert"),
            opprettet = row.localDateTime("sist_endret"),
            status = row.stringOrNull("status")?.let {
                IAProsessStatus.valueOf(it)
            },
            eidAv = row.stringOrNull("eid_av"),
            sistEndret = row.localDateOrNull("endret")?.toKotlinLocalDate()
        )
    }

    private fun mapRowTo4Kvaraler(row: Row): SykefraversstatistikkForVirksomhetSiste4Kvartaler {
        val kvartalListeType = object : TypeToken<List<Kvartal>>() {}.type
        return SykefraversstatistikkForVirksomhetSiste4Kvartaler(
            virksomhetsnavn = row.string("navn"),
            kommune = Kommune(row.string("kommune"), row.string("kommunenummer")),
            orgnr = row.string("orgnr"),
            arstall = row.int("arstall"),
            kvartal = row.int("kvartal"),
            antallPersoner = row.double("antall_personer"),
            tapteDagsverk = row.doubleOrNull("tapte_dagsverk") ?: 0.0,
            muligeDagsverk = row.doubleOrNull("mulige_dagsverk") ?: 0.0,
            sykefraversprosent = row.doubleOrNull("prosent") ?: 0.0,
            maskert = row.boolean("maskert"),
            opprettet = row.localDateTime("sist_endret"),
            status = row.stringOrNull("status")?.let {
                IAProsessStatus.valueOf(it)
            },
            eidAv = row.stringOrNull("eid_av"),
            sistEndret = row.localDateOrNull("endret")?.toKotlinLocalDate(),
            antallKvartaler = row.int("antall_kvartaler"),
            kvartaler = gson.fromJson(row.string("kvartaler"), kvartalListeType),
        )
    }
}
