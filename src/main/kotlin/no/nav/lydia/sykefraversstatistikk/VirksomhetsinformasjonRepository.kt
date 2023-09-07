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
import no.nav.lydia.sykefraversstatistikk.api.SnittFilter
import no.nav.lydia.sykefraversstatistikk.api.Sorteringsnøkkel
import no.nav.lydia.sykefraversstatistikk.api.Sorteringsnøkkel.*
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåSnitt
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåBransjeOgNæring
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåEiere
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåKommuner
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåSektor
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåStatus
import no.nav.lydia.sykefraversstatistikk.domene.Virksomhetsoversikt
import no.nav.lydia.sykefraversstatistikk.domene.VirksomhetsstatistikkSiste4Kvartal
import no.nav.lydia.sykefraversstatistikk.domene.VirksomhetsstatistikkSisteKvartal
import no.nav.lydia.sykefraversstatistikk.import.Kvartal
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
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
                virksomhet.orgnr,
                virksomhet.navn,
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
                JOIN virksomhet_naringsundergrupper AS vn on (virksomhet.id = vn.virksomhet) 
                ${
                    if (sektorer.isNotEmpty()) " LEFT JOIN virksomhet_statistikk_metadata USING (orgnr) "
                    else ""
                }
                LEFT JOIN ia_sak ON (
                    (ia_sak.orgnr = statistikk.orgnr) AND
                    ia_sak.endret = (select max(endret) from ia_sak iasak2 where iasak2.orgnr = statistikk.orgnr)
                )
                ${
                    if (søkeparametere.snittFilter == SnittFilter.BRANSJE_NÆRING_OVER
                            || søkeparametere.snittFilter == SnittFilter.BRANSJE_NÆRING_UNDER_ELLER_LIK) {
                              " JOIN sykefravar_statistikk_kategori_siste_4_kvartal AS naring_siste4 on (substr(vn.naringsundergruppe1, 1, 2) = naring_siste4.kode AND naring_siste4.kategori = 'NÆRING')" +
                                      " LEFT JOIN naringsundergrupper_per_bransje AS bransjeprogram on (vn.naringsundergruppe1 = bransjeprogram.naringsundergruppe)" +
                                      " LEFT JOIN sykefravar_statistikk_kategori_siste_4_kvartal AS bransje_siste4 on (bransjeprogram.bransje = bransje_siste4.kode AND bransje_siste4.kategori = 'BRANSJE') "
                            } else ""
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
                ${filtrerPåSnitt(søkeparametere = søkeparametere)}
                
                ${søkeparametere.ansatteFra?.let { " AND statistikk.antall_personer >= $it " } ?: ""}
                ${søkeparametere.ansatteTil?.let { " AND statistikk.antall_personer <= $it " } ?: ""}
                
                AND virksomhet.status = '${VirksomhetStatus.AKTIV.name}'
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
        ).map(this::mapRowToOversikt).asList
        session.run(query)
    }


    private fun Sorteringsnøkkel.tilOrderBy(): String {
        return when (this) {
            NAVN_PÅ_VIRKSOMHET -> "ORDER BY virksomhet.navn"
            ANTALL_PERSONER -> "ORDER BY statistikk.antall_personer"
            SYKEFRAVÆRSPROSENT -> "ORDER BY statistikk_siste4.prosent"
            TAPTE_DAGSVERK -> "ORDER BY statistikk_siste4.tapte_dagsverk"
            MULIGE_DAGSVERK -> "ORDER BY statistikk_siste4.mulige_dagsverk"
            SIST_ENDRET -> "ORDER BY ia_sak.endret"
        }
    }

    fun hentTotaltAntallVirksomheter(søkeparametere: Søkeparametere): Int? = using(sessionOf(dataSource)) { session ->
        val næringsgrupperMedBransjer = søkeparametere.næringsgrupperMedBransjer()
        val sektorer = søkeparametere.sektor.map { it.kode }.toSet()

        val sql = """
            SELECT
                COUNT(statistikk_siste4.orgnr) AS total
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
                JOIN virksomhet_naringsundergrupper AS vn on (virksomhet.id = vn.virksomhet)
                ${
                    if (søkeparametere.snittFilter == SnittFilter.BRANSJE_NÆRING_OVER 
                            || søkeparametere.snittFilter == SnittFilter.BRANSJE_NÆRING_UNDER_ELLER_LIK) {
                              " JOIN sykefravar_statistikk_kategori_siste_4_kvartal AS naring_siste4 on (substr(vn.naringsundergruppe1, 1, 2) = naring_siste4.kode AND naring_siste4.kategori = 'NÆRING')" +
                                      " LEFT JOIN naringsundergrupper_per_bransje AS bransjeprogram on (vn.naringsundergruppe1 = bransjeprogram.naringsundergruppe)" +
                                      " LEFT JOIN sykefravar_statistikk_kategori_siste_4_kvartal AS bransje_siste4 on (bransjeprogram.bransje = bransje_siste4.kode AND bransje_siste4.kategori = 'BRANSJE') "                        
                            } else ""
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
                ${filtrerPåSnitt(søkeparametere = søkeparametere)}
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
            opprettet = row.localDateTime("sist_endret"),
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
}
