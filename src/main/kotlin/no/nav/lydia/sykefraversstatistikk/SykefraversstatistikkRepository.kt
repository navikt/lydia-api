package no.nav.lydia.sykefraversstatistikk

import kotliquery.queryOf
import kotliquery.sessionOf
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

}