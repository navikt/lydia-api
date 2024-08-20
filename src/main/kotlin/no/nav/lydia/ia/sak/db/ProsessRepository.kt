package no.nav.lydia.ia.sak.db

import javax.sql.DataSource
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.ProsessHendelse
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


    fun oppdaterProsess(sakshendelse: IASakshendelse) {
        when (sakshendelse) {
            is ProsessHendelse -> {
                using(sessionOf(dataSource)) { session ->
                    session.run(
                        queryOf(
                            """
                                UPDATE ia_prosess SET navn = :navn WHERE id = :prosessId
                            """.trimIndent(),
                            mapOf(
                                "navn" to sakshendelse.prosessDto.navn,
                                "prosessId" to sakshendelse.prosessDto.id
                            )
                        ).asUpdate
                    )
                }
            }

            else -> {
                when (sakshendelse.hendelsesType) {
                    IASakshendelseType.VIRKSOMHET_KARTLEGGES -> hentProsess(saksnummer = sakshendelse.saksnummer) ?: opprettNyProsess(saksnummer = sakshendelse.saksnummer)
                    else -> {}
                }
            }
        }
    }

    private fun mapRowToIaProsessDto(row: Row) =
        IAProsess(
            id = row.int("id"),
            saksnummer = row.string("saksnummer"),
            navn = row.stringOrNull("navn")
        )
}
