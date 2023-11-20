package no.nav.lydia.vedlikehold

import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import javax.sql.DataSource
import kotlin.system.measureTimeMillis

class StatistikkViewOppdaterer(val dataSource: DataSource) {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)

    fun oppdaterStatistikkView() {
        logger.info("Oppdaterer statistikkview...")
        val tidBrukt = measureTimeMillis {
            using(sessionOf(dataSource)) { session ->
                session.run(
                    queryOf(
                        "REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering"
                    ).asExecute
                )
            }
        }
        logger.info("Oppdaterte statistikkview på $tidBrukt ms")
    }
}
