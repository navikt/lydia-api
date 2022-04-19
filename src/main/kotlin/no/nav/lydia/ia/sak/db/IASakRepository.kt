package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.rightIfNotNull
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.domene.*
import javax.sql.DataSource

class IASakRepository(val dataSource: DataSource) {

    fun opprettSak(iaSak: IASak): IASak =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    INSERT INTO ia_sak (
                        saksnummer,
                        orgnr,
                        type,
                        status,
                        opprettet_av,
                        opprettet,
                        endret_av_hendelse
                    )
                    VALUES (
                        :saksnummer,
                        :orgnr,
                        :type,
                        :status,
                        :opprettet_av,
                        :opprettet,
                        :endret_av_hendelse
                    )
                    returning *                            
                """.trimMargin(),
                    mapOf(
                        "saksnummer" to iaSak.saksnummer,
                        "orgnr" to iaSak.orgnr,
                        "type" to iaSak.type.name,
                        "status" to iaSak.status.name,
                        "opprettet_av" to iaSak.opprettetAv,
                        "opprettet" to iaSak.opprettet,
                        "endret_av_hendelse" to iaSak.endretAvHendelseId
                    )
                ).map(this::mapRowToIASak).asSingle
            )!!
        }

    fun oppdaterSak(iaSak: IASak) : Either<IASakError, IASak> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak 
                    SET
                        type = :type,
                        status = :status,
                        endret_av = :endret_av,
                        endret = :endret,
                        eid_av = :eidAv,
                        endret_av_hendelse = :endret_av_hendelse
                    WHERE saksnummer = :saksnummer
                    RETURNING *
                """.trimMargin(),
                    mapOf(
                        "saksnummer" to iaSak.saksnummer,
                        "type" to iaSak.type.name,
                        "status" to iaSak.status.name,
                        "endret_av" to iaSak.endretAv,
                        "endret" to iaSak.endret,
                        "eidAv" to iaSak.eidAv,
                        "endret_av_hendelse" to iaSak.endretAvHendelseId
                    )
                ).map(this::mapRowToIASak).asSingle
            ).rightIfNotNull { IASakError.FikkIkkeOppdatertSak }
        }

    private fun mapRowToIASak(row: Row): IASak {
        return IASak(
            saksnummer = row.string("saksnummer"),
            orgnr = row.string("orgnr"),
            type = IASakstype.valueOf(row.string("type")),
            opprettet = row.localDateTime("opprettet"),
            opprettetAv = row.string("opprettet_av"),
            endret = row.localDateTimeOrNull("endret"),
            endretAv = row.stringOrNull("endret_av"),
            status = IAProsessStatus.valueOf(row.string("status")),
            endretAvHendelseId = row.string("endret_av_hendelse"),
            eidAv = row.stringOrNull("eid_av")
        )
    }

    fun hentSaker(orgnummer: String): List<IASak> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak
                    WHERE orgnr = :orgnr
                """.trimMargin(),
                    mapOf(
                        "orgnr" to orgnummer,
                    )
                ).map(this::mapRowToIASak).asList
            )
        }
}

