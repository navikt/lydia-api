package no.nav.lydia.ia.sak.db

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakstype
import javax.sql.DataSource

class IASakRepository(val dataSource: DataSource) {

    fun findOrInsert(orgnr: String) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                            INSERT INTO ia_sak (
                                saksnummer,
                                orgnr,
                                type,
                                status,
                                opprettet_av
                            )
                            VALUES (
                                :saksnummer,
                                :orgnr,
                                :type,
                                :status,
                                :opprettet_av
                            )
                            returning *                            
                       """.trimMargin(),
                    mapOf(
                        "orgnr" to orgnr
                    )
                ).asUpdate
            )
        }
    }

    fun finn(orgnr: String) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak
                        WHERE orgnr = :orgnr 
                        AND status NOT IN (:avsluttet)                            
                       """.trimMargin(),
                    mapOf(
                        "orgnr" to orgnr
                    )
                ).map(this::mapRow).asList
            )
        }
    }

    private fun mapRow(row: Row): IASak {
        return IASak(
            saksnummer = row.string("saksnummer"),
            orgnr = row.string("orgnr"),
            type = IASakstype.valueOf(row.string("type")),
            opprettet = row.localDateTime("opprettet"),
                    opprettet_av = row.string("opprettet_av"),
                    endret = row.localDateTime("endret"),
                    endretAv = row.string("endretAv"),
                    tilstand = IIAProsessStatus.valueOf(row.string("status"))
        )
    }

    fun hentIASaker(orgnummer: String): List<IASak> {
        TODO("Not yet implemented")
    }
}