package no.nav.lydia.ia.grunnlag

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.sykefraversstatistikk.api.geografi.NavEnheter
import javax.sql.DataSource

class SykefraversstatistikkGrunnlagRepository(val dataSource: DataSource) {

    fun insert(sykefraversstatistikkGrunnlagListe: List<SykefraversstatistikkGrunnlag>) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                sykefraversstatistikkGrunnlagListe.forEach { sykefraværsStatistikkGrunnlag ->
                    tx.run(
                        queryOf(
                            """
                       INSERT INTO sykefravar_statistikk_grunnlag(
                        
                        saksnummer,
                        hendelse_id,
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
                        :saksnummer,
                        :hendelse_id,
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
                                "saksnummer" to sykefraværsStatistikkGrunnlag.saksnummer,
                                "hendelse_id" to sykefraværsStatistikkGrunnlag.hendelseId,
                                "orgnr" to sykefraværsStatistikkGrunnlag.orgnr,
                                "arstall" to sykefraværsStatistikkGrunnlag.arstall,
                                "kvartal" to sykefraværsStatistikkGrunnlag.kvartal,
                                "antall_personer" to sykefraværsStatistikkGrunnlag.antallPersoner,
                                "tapte_dagsverk" to sykefraværsStatistikkGrunnlag.tapteDagsverk,
                                "mulige_dagsverk" to sykefraværsStatistikkGrunnlag.muligeDagsverk,
                                "sykefraversprosent" to sykefraværsStatistikkGrunnlag.sykefraversprosent,
                                "maskert" to sykefraværsStatistikkGrunnlag.maskert
                            )
                        ).asUpdate
                    )

                }
            }
        }
    }

    fun hentSykefraværstatistikkGrunnlag(orgnr: String): List<SykefraversstatistikkGrunnlag> {
        return using(sessionOf(dataSource)) { session ->
            val query = queryOf(
                statement = """
                    SELECT
                        saksnummer,
                        hendelse_id,
                        orgnr,
                        arstall,
                        kvartal,
                        antall_personer,
                        tapte_dagsverk,
                        mulige_dagsverk,
                        sykefraversprosent,
                        maskert,
                        opprettet
                  FROM sykefravar_statistikk_grunnlag
                  WHERE orgnr = :orgnr AND orgnr NOT in ${NavEnheter.enheterSomSkalSkjermes.joinToString(prefix = "(", postfix = ")", separator = ",") {s -> "\'$s\'"}}
                """.trimIndent(),
                paramMap = mapOf(
                    "orgnr" to orgnr
                )
            ).map(this::mapRow).asList
            session.run(query)
        }
    }

    private fun mapRow(row: Row): SykefraversstatistikkGrunnlag {
        return SykefraversstatistikkGrunnlag(
            saksnummer = row.string("saksnummer"),
            hendelseId = row.string("hendelse_id"),
            orgnr = row.string("orgnr"),
            arstall = row.int("arstall"),
            kvartal = row.int("kvartal"),
            antallPersoner = row.double("antall_personer"),
            tapteDagsverk = row.double("tapte_dagsverk"),
            muligeDagsverk = row.double("mulige_dagsverk"),
            sykefraversprosent = row.double("sykefraversprosent"),
            maskert = row.boolean("maskert"),
            opprettet = row.localDateTime("opprettet")
        )
    }
}
