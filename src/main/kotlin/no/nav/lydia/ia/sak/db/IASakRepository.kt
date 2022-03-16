package no.nav.lydia.ia.sak.db

import com.github.guepardoapps.kulid.ULID
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakstype
import javax.sql.DataSource

class IASakRepository(val dataSource: DataSource) {
    fun finnEllerOpprettSak(orgnr: String, ident: String, type: IASakstype) =
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                        SELECT *
                            FROM ia_sak
                            WHERE orgnr = :orgnr 
                            AND status NOT IN (:avsluttet)                            
                    """.trimMargin(),
                        mapOf(
                            "orgnr" to orgnr,
                            "avsluttet" to IAProsessStatus.avsluttedeStatuser()
                                .joinToString(transform = { "'${it.name}'" }, separator = ",")
                        )
                    ).map(this::mapRow).asSingle
                ) ?: tx.run(
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
                            "saksnummer" to ULID.random(),
                            "orgnr" to orgnr,
                            "type" to type.name,
                            "status" to IAProsessStatus.NY.name,
                            "opprettet_av" to ident
                        )
                    ).map(this::mapRow).asSingle
                )!!
            }
        }

    fun oppdaterSak(sak: IASak) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                UPDATE ia_sak SET
                    status = :status,
                    type = :type,
                    endret_av = :endretAv,
                    endret = :endret
            """.trimIndent(),
                    mapOf(
                        "status" to sak.status.name,
                        "type" to sak.type.name,
                        "endret_av" to sak.endretAv,
                        "endret" to sak.endret,
                    )
                ).asUpdate
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
            endret = row.localDateTimeOrNull("endret"),
            endretAv = row.stringOrNull("endret_av"),
            status = IAProsessStatus.valueOf(row.string("status"))
        )
    }
}