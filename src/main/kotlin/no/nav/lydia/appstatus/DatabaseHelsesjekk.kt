package no.nav.lydia.appstatus

import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import org.slf4j.LoggerFactory
import javax.sql.DataSource

class DatabaseHelsesjekk(private val dataSource: DataSource): Helsesjekk {

    private val log = LoggerFactory.getLogger(this.javaClass)

    override fun helse(): Helse {
        return using(sessionOf(dataSource)) {
            session ->
            try {
                session.run(queryOf(statement = "SELECT 1").map {
                    Helse.UP
                }.asSingle)!!
            } catch (e: Exception) {
                log.error("Helsesjekk feilet:", e)
                Helse.DOWN
            }

        }
    }
}

