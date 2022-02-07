package no.nav.lydia.sykefraversstatistikk

import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkImportDto
import javax.sql.DataSource

class SykefraversstatistikkRepository(val dataSource: DataSource) {

    fun insert(sykefraversstatistikkVirksomhet: SykefraversstatistikkImportDto) {
        val session = sessionOf(dataSource)
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
                    "orgnr" to sykefraversstatistikkVirksomhet.orgnr,
                    "arstall" to sykefraversstatistikkVirksomhet.arstall,
                    "kvartal" to sykefraversstatistikkVirksomhet.kvartal,
                    "antall_personer" to sykefraversstatistikkVirksomhet.antallPersoner,
                    "tapte_dagsverk" to sykefraversstatistikkVirksomhet.tapteDagsverk,
                    "mulige_dagsverk" to sykefraversstatistikkVirksomhet.muligeDagsverk,
                    "sykefraversprosent" to sykefraversstatistikkVirksomhet.sykefraversprosent,
                    "maskert" to sykefraversstatistikkVirksomhet.maskert
                )
            ).asUpdate
        )
    }

    fun hentSykefravær(orgnr: String): List<SykefraversstatistikkVirksomhet> {
        return using(sessionOf(dataSource)) { session ->
            val query = queryOf(
                statement = "SELECT * FROM sykefravar_statistikk_virksomhet WHERE (orgnr = :orgnr)",
                paramMap = mapOf("orgnr" to orgnr)
            ).map { row ->
                SykefraversstatistikkVirksomhet(
                    id = row.string("id"),
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
            }.asList
            session.run(query)
        }
    }


}