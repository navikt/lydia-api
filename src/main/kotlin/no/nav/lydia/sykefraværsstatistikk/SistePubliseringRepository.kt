package no.nav.lydia.sykefraværsstatistikk

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.sykefraværsstatistikk.PubliseringsinfoDto.Companion.tilPubliseringsinfo
import javax.sql.DataSource

class SistePubliseringRepository(
    val dataSource: DataSource,
) {
    fun hentPubliseringsinfo(): PubliseringsinfoDto =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM siste_publiseringsinfo
                    ORDER BY gjeldende_arstall DESC, gjeldende_kvartal DESC
                    LIMIT 1
                    """.trimMargin(),
                ).map(this::mapRowToPubliseringsinfo).asSingle,
            ) ?: throw NoSuchElementException("Ingen publiseringsinfo funnet")
        }

    fun hentAllPubliseringsinfo() =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM siste_publiseringsinfo
                        ORDER BY gjeldende_arstall DESC, gjeldende_kvartal DESC
                    """.trimMargin(),
                ).map(this::mapRowToPubliseringsinfo).asList,
            )
        }

    private fun mapRowToPubliseringsinfo(row: Row): PubliseringsinfoDto = row.tilPubliseringsinfo()
}
