package no.nav.lydia.sykefraversstatistikk

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.sykefraversstatistikk.Publiseringsinfo.Companion.tilPubliseringsinfo
import javax.sql.DataSource

class SistePubliseringRepository(val dataSource: DataSource) {

    fun hentPubliseringsinfo(): Publiseringsinfo =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM siste_publiseringsinfo
                    ORDER BY opprettet DESC
                    LIMIT 1
                """.trimMargin()
                ).map(this::mapRowToPubliseringsinfo).asSingle
            ) ?: throw NoSuchElementException("Ingen publiseringsinfo funnet")
        }

    private fun mapRowToPubliseringsinfo(row: Row): Publiseringsinfo {
        return row.tilPubliseringsinfo()
    }
}
