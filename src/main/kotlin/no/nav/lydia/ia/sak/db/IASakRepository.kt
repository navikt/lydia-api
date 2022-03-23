package no.nav.lydia.ia.sak.db

import com.github.guepardoapps.kulid.ULID
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.*
import javax.sql.DataSource

class IASakRepository(val dataSource: DataSource) {
    fun lagreSak(iaSak: IASak): IASak =
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
                        opprettet
                    )
                    VALUES (
                        :saksnummer,
                        :orgnr,
                        :type,
                        :status,
                        :opprettet_av,
                        :opprettet
                    )
                    returning *                            
                """.trimMargin(),
                    mapOf(
                        "saksnummer" to iaSak.saksnummer,
                        "orgnr" to iaSak.orgnr,
                        "type" to iaSak.type.name,
                        "status" to iaSak.status.name,
                        "opprettet_av" to iaSak.opprettet_av,
                        "opprettet" to iaSak.opprettet
                    )
                ).map(this::mapRowToIASak).asSingle
            )!!
        }

    fun oppdaterSak(iaSak: IASak): IASak =
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
                        opprettet
                    )
                    VALUES (
                        :saksnummer,
                        :orgnr,
                        :type,
                        :status,
                        :opprettet_av,
                        :opprettet
                    )
                    returning *                            
                """.trimMargin(),
                    mapOf(
                        "saksnummer" to iaSak.saksnummer,
                        "orgnr" to iaSak.orgnr,
                        "type" to iaSak.type.name,
                        "status" to iaSak.status.name,
                        "opprettet_av" to iaSak.opprettet_av,
                        "opprettet" to iaSak.opprettet
                    )
                ).map(this::mapRowToIASak).asSingle
            )!!
        }


    fun hentAktivSakForVirksomhet(orgnummer: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                SELECT *
                    FROM ia_sak
                    WHERE orgnr = :orgnr
                    AND status NOT IN (:avsluttedeStatuser)
                """.trimMargin(),
                    mapOf(
                        "orgnr" to orgnummer,
                        "avsluttedeStatuser" to IAProsessStatus.avsluttedeStatuser()
                            .joinToString(", ", transform = { status -> "'${status.name}'" })
                    )
                ).map(this::mapRowToIASak).asSingle
            )
        }

    fun hentIASakPåOrgnummer(orgnummer: String) =
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

    fun hentIASakPåSaksnummer(saksnummer: String): IASak? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                        FROM ia_sak
                        WHERE saksnummer = :saksnummer 
                    """.trimMargin(),
                    mapOf(
                        "saksnummer" to saksnummer,
                    )
                ).map(this::mapRowToIASak).asSingle
            )
        }

    fun opprettHendelseOgOppdaterSak(sakshendelse: IASakshendelse, forrigeHendelsesId: String?, oppdatertSak: IASak) =
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                        INSERT INTO ia_sak_hendelse (
                            id,
                            saksnummer,
                            orgnr,
                            type,
                            opprettet_av,
                            opprettet
                        )
                        VALUES (
                            :id,
                            :saksnummer,
                            :orgnr,
                            :type,
                            :opprettet_av,
                            :opprettet
                        ) 
                        returning *  
                """.trimMargin(),
                        mapOf(
                            "id" to sakshendelse.id,
                            "saksnummer" to sakshendelse.saksnummer,
                            "orgnr" to sakshendelse.orgnummer,
                            "type" to sakshendelse.type,
                            "opprettet_av" to sakshendelse.opprettetAv,
                            "opprettet" to sakshendelse.opprettetTidspunkt
                        )
                    ).map(this::mapRowToIASakshendelse).asSingle
                )
                tx.run(
                    queryOf(
                        """
                        UPDATE ia_sak SET
                            status = :status,
                            type = :type,
                            endret_av = :endretAv,
                            endret = :endret
                            forrige_hendelse_id = :nye_forrige_hendelse_id 
                        WHERE forrige_hendelse_id = :gamle_forrige_hendelse_id;
                        """.trimIndent(),
                        mapOf(
                            "status" to oppdatertSak.status.name,
                            "type" to oppdatertSak.type.name,
                            "endret_av" to oppdatertSak.endretAv,
                            "endret" to oppdatertSak.endret,
                            "nye_forrige_hendelse_id" to sakshendelse.id,
                            "gamle_forrige_hendelse_id" to forrigeHendelsesId,
                        )
                    ).asUpdate
                )
            }
        }

    private fun mapRowToIASak(row: Row): IASak {
        return IASak(
            saksnummer = row.string("saksnummer"),
            orgnr = row.string("orgnr"),
            type = IASakstype.valueOf(row.string("type")),
            opprettet = row.localDateTime("opprettet"),
            opprettet_av = row.string("opprettet_av"),
            endret = row.localDateTimeOrNull("endret"),
            endretAv = row.stringOrNull("endret_av"),
            status = IAProsessStatus.valueOf(row.string("status")),
            endretAvHendelseId = row.string("forrige_hendelse_id")
        )
    }

    private fun mapRowToIASakshendelse(row: Row): IASakshendelse {
        return IASakshendelse(
            id = row.string("id"),
            type = SaksHendelsestype.valueOf(row.string("type")),
            orgnummer = row.string("orgnr"),
            opprettetAv = row.string("navIdent"),
            saksnummer = row.string("saksnummer"),
            opprettetTidspunkt = row.localDateTime("opprettet"),
        )
    }
}

