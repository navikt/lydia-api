package no.nav.lydia.ia.sak.db

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.domene.ProsessHendelse
import no.nav.lydia.ia.sak.domene.prosess.IAProsess
import javax.sql.DataSource
import no.nav.lydia.ia.sak.domene.prosess.IAProsessStatus

class ProsessRepository(val dataSource: DataSource) {

    fun hentProsess(saksnummer: String, prosessId: Int) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_prosess
                        WHERE saksnummer = :saksnummer
                        AND id = :prosessId
                        AND status = 'AKTIV'
                    """.trimIndent(),
                    mapOf(
                        "saksnummer" to saksnummer,
                        "prosessId" to prosessId
                    )
                ).map(this::mapRowToIaProsessDto).asSingle
            )
        }

    fun hentProsesser(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_prosess
                        WHERE saksnummer = :saksnummer
                        AND status = 'AKTIV'
                    """.trimIndent(),
                    mapOf(
                        "saksnummer" to saksnummer
                    )
                ).map(this::mapRowToIaProsessDto).asList
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


    fun oppdaterNavnPåProsess(prosessDto: IAProsessDto) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                                UPDATE ia_prosess SET navn = :navn WHERE id = :prosessId
                            """.trimIndent(),
                    mapOf(
                        "navn" to prosessDto.navn,
                        "prosessId" to prosessDto.id
                    )
                ).asUpdate
            )
        }
    }

    private fun mapRowToIaProsessDto(row: Row) =
        IAProsess(
            id = row.int("id"),
            saksnummer = row.string("saksnummer"),
            navn = row.stringOrNull("navn"),
            status = IAProsessStatus.valueOf(row.string("status")),
        )

    fun oppdaterTilSlettetStatus(prosessHendelse: ProsessHendelse) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_prosess
                     SET status = 'SLETTET'
                     WHERE id = :prosessId
                     AND saksnummer = :saksnummer
                    """.trimIndent(),
                    mapOf(
                        "prosessId" to prosessHendelse.prosessDto.id,
                        "saksnummer" to prosessHendelse.saksnummer
                    )
                ).asUpdate
            )
        }

}
