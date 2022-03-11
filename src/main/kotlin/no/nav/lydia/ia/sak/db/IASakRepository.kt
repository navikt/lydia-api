package no.nav.lydia.ia.sak.db

import com.github.guepardoapps.kulid.ULID
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakstype
import no.nav.lydia.ia.sak.domene.ProsessTilstand
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

    private fun mapRow(row: Row): IASak {
        return IASak(
            saksnummer = row.string("saksnummer"),
            orgnr = row.string("orgnr"),
            type = IASakstype.valueOf(row.string("type")),
            opprettet = row.localDateTime("opprettet"),
            opprettet_av = row.string("opprettet_av"),
            endret = row.localDateTimeOrNull("endret"),
            endretAv = row.stringOrNull("endret_av"),
            tilstand = ProsessTilstand.iStatus(IAProsessStatus.valueOf(row.string("status")))
        )
    }
}