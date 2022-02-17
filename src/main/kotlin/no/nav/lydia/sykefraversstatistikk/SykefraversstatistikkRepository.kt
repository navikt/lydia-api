package no.nav.lydia.sykefraversstatistikk

import VirksomhetSykefravær
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet
import javax.sql.DataSource

class SykefraversstatistikkRepository(val dataSource: DataSource) {
    fun insert(virksomhetSykefravær: VirksomhetSykefravær) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                       INSERT INTO sykefravar_statistikk_virksomhet(
                        orgnr,
                        arstall,
                        kvartal,
                        antall_personer,
                        tapte_dagsverk,
                        mulige_dagsverk,
                        sykefraversprosent,
                        maskert
                       )
                        VALUES(
                        :orgnr,
                        :arstall,
                        :kvartal,
                        :antall_personer,
                        :tapte_dagsverk,
                        :mulige_dagsverk,
                        :sykefraversprosent,
                        :maskert
                        ) 
                        ON CONFLICT DO NOTHING
                        """.trimMargin(),
                    mapOf(
                        "orgnr" to virksomhetSykefravær.orgnr,
                        "arstall" to virksomhetSykefravær.årstall,
                        "kvartal" to virksomhetSykefravær.kvartal,
                        "antall_personer" to virksomhetSykefravær.antallPersoner,
                        "tapte_dagsverk" to virksomhetSykefravær.tapteDagsverk,
                        "mulige_dagsverk" to virksomhetSykefravær.muligeDagsverk,
                        "sykefraversprosent" to virksomhetSykefravær.prosent,
                        "maskert" to virksomhetSykefravær.maskert
                    )
                ).asUpdate
            )
        }
    }

    fun hentAltSykefravær(): List<SykefraversstatistikkVirksomhet> {
        return using(sessionOf(dataSource)) { session ->
            val sql = """
                    SELECT
                        statistikk.orgnr,
                        virksomhet.navn,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        statistikk.arstall,
                        statistikk.kvartal,
                        statistikk.antall_personer,
                        statistikk.tapte_dagsverk,
                        statistikk.mulige_dagsverk,
                        statistikk.sykefraversprosent,
                        statistikk.maskert,
                        statistikk.opprettet
                    FROM sykefravar_statistikk_virksomhet AS statistikk
                    LEFT JOIN virksomhet USING (orgnr)
                """.trimIndent()
            val query = queryOf(
                statement = sql
            ).map(this::mapRow).asList
            session.run(query)
        }
    }

    fun hentSykefraværIKommuner(kommuner: Set<String>): List<SykefraversstatistikkVirksomhet> {
        return using(sessionOf(dataSource)) { session ->
            val sql = """
                    SELECT
                        statistikk.orgnr,
                        virksomhet.navn,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        statistikk.arstall,
                        statistikk.kvartal,
                        statistikk.antall_personer,
                        statistikk.tapte_dagsverk,
                        statistikk.mulige_dagsverk,
                        statistikk.sykefraversprosent,
                        statistikk.maskert,
                        statistikk.opprettet
                    FROM sykefravar_statistikk_virksomhet AS statistikk
                    LEFT JOIN virksomhet USING (orgnr)
                    WHERE virksomhet.kommunenummer IN (${kommuner.joinToString(transform = { "?" })})
                """.trimIndent()
            val query = queryOf(
                statement = sql,
                *kommuner.toTypedArray()
            ).map(this::mapRow).asList
            session.run(query)
        }
    }

    private fun mapRow(row: Row): SykefraversstatistikkVirksomhet {
        return SykefraversstatistikkVirksomhet(
            virksomhetsnavn = row.stringOrNull("navn"),
            kommune = Kommune.kommune(row.stringOrNull("kommune"), row.stringOrNull("kommunenummer")),
            orgnr = row.string("orgnr"),
            arstall = row.int("arstall"),
            kvartal = row.int("kvartal"),
            antallPersoner = row.double("antall_personer"),
            tapteDagsverk = row.double("tapte_dagsverk"),
            muligeDagsverk = row.double("mulige_dagsverk"),
            sykefraversprosent = row.double("sykefraversprosent"),
            maskert = row.boolean("maskert"),
            opprettet = row.localDateTime("opprettet"),
        )
    }

    fun hentSykefravær(orgnr: String): List<SykefraversstatistikkVirksomhet> {
        return using(sessionOf(dataSource)) { session ->
            val query = queryOf(
                statement = """
                    SELECT
                        statistikk.orgnr,
                        virksomhet.navn,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        statistikk.arstall,
                        statistikk.kvartal,
                        statistikk.antall_personer,
                        statistikk.tapte_dagsverk,
                        statistikk.mulige_dagsverk,
                        statistikk.sykefraversprosent,
                        statistikk.maskert,
                        statistikk.opprettet
                  FROM sykefravar_statistikk_virksomhet AS statistikk
                  LEFT JOIN virksomhet USING (orgnr)
                  WHERE (statistikk.orgnr = :orgnr)
                """.trimIndent(),
                paramMap = mapOf("orgnr" to orgnr)
            ).map(this::mapRow).asList
            session.run(query)
        }
    }


}