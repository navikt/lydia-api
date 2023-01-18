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

        val sql = """
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
            FROM 
                sykefravar_statistikk_virksomhet AS statistikk
                JOIN virksomhet USING (orgnr)
                JOIN sykefravar_statistikk_virksomhet_siste_4_kvartal AS statistikk_siste4 USING (orgnr)
                ${
                    if (sektorer.isNotEmpty()) " LEFT JOIN virksomhet_statistikk_metadata USING (orgnr) "
                    else ""
                }
                LEFT JOIN ia_sak ON (
                    (ia_sak.orgnr = statistikk.orgnr) AND
                    ia_sak.endret = (select max(endret) from ia_sak iasak2 where iasak2.orgnr = statistikk.orgnr)
                )
                ${
                    if (næringsgrupperMedBransjer.isNotEmpty()) " JOIN virksomhet_naring AS vn on (virksomhet.id = vn.virksomhet) "
                    else ""
                }
                
            WHERE 
                statistikk.arstall = :arstall
                AND statistikk.kvartal = :kvartal
                
                ${filtrerPåBransjeOgNæring(søkeparametere = søkeparametere)}
                ${filtrerPåKommuner(søkeparametere = søkeparametere)}
                ${filtrerPåStatus(søkeparametere = søkeparametere)}
                ${filtrerPåSektor(søkeparametere = søkeparametere)}
                ${filtrerPåEiere(søkeparametere = søkeparametere)}
                
                ${søkeparametere.sykefraværsprosentFra?.let { " AND statistikk_siste4.prosent >= $it " } ?: ""}
                ${søkeparametere.sykefraværsprosentTil?.let { " AND statistikk_siste4.prosent <= $it " } ?: ""}
                
                ${søkeparametere.ansatteFra?.let { " AND statistikk.antall_personer >= $it " } ?: ""}
                ${søkeparametere.ansatteTil?.let { " AND statistikk.antall_personer <= $it " } ?: ""}
                
                AND virksomhet.status = '${VirksomhetStatus.AKTIV.name}'
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
            statement = sql,
            mapOf(
                "kvartal" to søkeparametere.periode.kvartal,
                "arstall" to søkeparametere.periode.årstall,

                "naringer" to session.createArrayOf("text", næringsgrupperMedBransjer),
                "kommuner" to session.createArrayOf("text", søkeparametere.kommunenummer),
                "sektorer" to session.createArrayOf("text", sektorer),
                "eiere" to session.createArrayOf("text", søkeparametere.navIdenter),
            )
        ).map(this::mapRow).asList
        session.run(query)
    }

    private fun filtrerPåEiere(søkeparametere: Søkeparametere) =
        if (søkeparametere.navIdenter.isEmpty()) ""
        else " AND ia_sak.eid_av in (select unnest(:eiere)) "

    private fun filtrerPåSektor(søkeparametere: Søkeparametere) =
        if(søkeparametere.sektor.isEmpty()) ""
        else " AND virksomhet_statistikk_metadata.sektor in (select unnest(:sektorer)) "

    private fun filtrerPåStatus(søkeparametere: Søkeparametere) =
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

    private fun filtrerPåKommuner(søkeparametere: Søkeparametere) =
        if (søkeparametere.kommunenummer.isEmpty()) ""
        else " AND virksomhet.kommunenummer in (select unnest(:kommuner)) "

    private fun filtrerPåBransjeOgNæring(søkeparametere: Søkeparametere): String {
        val næringsgrupperMedBransjer = søkeparametere.næringsgrupperMedBransjer()
        return if (næringsgrupperMedBransjer.isEmpty())
            ""
        else
            """
                AND (
                    substr(vn.narings_kode, 1, 2) in (select unnest(:naringer))
                    ${
                        if (søkeparametere.bransjeprogram.isNotEmpty()) {
                            val koder = søkeparametere.bransjeprogram.flatMap { it.næringskoder }.groupBy {
                                it.length
                            }
                            val femsifrede = koder[5]?.joinToString { "'${it.take(2)}.${it.takeLast(3)}'" }
                            femsifrede?.let { "OR (vn.narings_kode in (select (unnest(:naringer))))" } ?: ""
                        } else ""
                    }
                    )
            """.trimIndent()
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

        val sql = """
            SELECT
                COUNT(DISTINCT virksomhet.orgnr) AS total
            FROM 
                sykefravar_statistikk_virksomhet AS statistikk
                JOIN virksomhet USING (orgnr)
                JOIN sykefravar_statistikk_virksomhet_siste_4_kvartal AS statistikk_siste4 USING (orgnr)
                ${
                    if (sektorer.isNotEmpty()) " LEFT JOIN virksomhet_statistikk_metadata USING (orgnr) "
                    else ""
                }
                LEFT JOIN ia_sak ON (
                    (ia_sak.orgnr = statistikk.orgnr) AND
                    ia_sak.endret = (select max(endret) from ia_sak iasak2 where iasak2.orgnr = statistikk.orgnr)
                )
                ${
                    if (næringsgrupperMedBransjer.isNotEmpty()) " JOIN virksomhet_naring AS vn on (virksomhet.id = vn.virksomhet) "
                    else ""
                }
                
            WHERE 
                statistikk.arstall = :arstall
                AND statistikk.kvartal = :kvartal
                
                ${filtrerPåBransjeOgNæring(søkeparametere = søkeparametere)}
                ${filtrerPåKommuner(søkeparametere = søkeparametere)}
                ${filtrerPåStatus(søkeparametere = søkeparametere)}
                ${filtrerPåSektor(søkeparametere = søkeparametere)}
                ${filtrerPåEiere(søkeparametere = søkeparametere)}
                
                ${søkeparametere.sykefraværsprosentFra?.let { " AND statistikk_siste4.prosent >= $it " } ?: ""}
                ${søkeparametere.sykefraværsprosentTil?.let { " AND statistikk_siste4.prosent <= $it " } ?: ""}
                
                ${søkeparametere.ansatteFra?.let { " AND statistikk.antall_personer >= $it " } ?: ""}
                ${søkeparametere.ansatteTil?.let { " AND statistikk.antall_personer <= $it " } ?: ""}
                
                AND virksomhet.status = '${VirksomhetStatus.AKTIV.name}'
                    """.trimIndent()

        val query = queryOf(
            statement = sql,
            mapOf(
                "kvartal" to søkeparametere.periode.kvartal,
                "arstall" to søkeparametere.periode.årstall,

                "naringer" to session.createArrayOf("text", næringsgrupperMedBransjer),
                "kommuner" to session.createArrayOf("text", søkeparametere.kommunenummer),
                "sektorer" to session.createArrayOf("text", sektorer),
                "eiere" to session.createArrayOf("text", søkeparametere.navIdenter),
            )
        )
        session.run(query.map { it.int("total") }.asSingle)
    }

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
