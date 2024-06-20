package no.nav.lydia.ia.sak.db

import javax.sql.DataSource
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.prosess.IAProsess

class ProsessRepository(val dataSource: DataSource) {

    fun hentProsess(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_prosess
                        WHERE saksnummer = :saksnummer
                    """.trimIndent(),
                    mapOf(
                        "saksnummer" to saksnummer
                    )
                ).map(this::mapRowToIaProsessDto).asSingle
            )
        }

    fun opprettNyProsess(saksnummer: String): IAProsess =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        INSERT INTO ia_prosess (saksnummer) 
                        values (:saksnummer)
                         returning *
                    """.trimIndent(),
                    mapOf(
                        "saksnummer" to saksnummer
                    )
                ).map(this::mapRowToIaProsessDto).asSingle
            )!!
    }


    private fun mapRowToIaProsessDto(row: Row) =
        IAProsess(
            id = row.int("id"),
            saksnummer = row.string("saksnummer")
        )
}
