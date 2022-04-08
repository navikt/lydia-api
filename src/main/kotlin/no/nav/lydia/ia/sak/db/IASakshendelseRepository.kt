package no.nav.lydia.ia.sak.db

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.*
import javax.sql.DataSource

class IASakshendelseRepository(val dataSource: DataSource) {

    fun hentHendelser(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf("""
                    SELECT * FROM ia_sak_hendelse
                    WHERE saksnummer = :saksnummer
                    ORDER BY id ASC
                """.trimIndent(),
                mapOf(
                    "saksnummer" to saksnummer
                ))
                .map(this::mapRow).asList
            )
        }

    fun lagreHendelse(hendelse : IASakshendelse) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf("""
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
                        "id" to hendelse.id,
                        "saksnummer" to hendelse.saksnummer,
                        "orgnr" to hendelse.orgnummer,
                        "type" to hendelse.hendelsesType.name,
                        "opprettet_av" to hendelse.opprettetAv,
                        "opprettet" to hendelse.opprettetTidspunkt
                    )
                ).map(this::mapRow).asSingle
            )!!
        }

    private fun mapRow(row: Row): IASakshendelse {
        return IASakshendelse(
            id = row.string("id"),
            hendelsesType = SaksHendelsestype.valueOf(row.string("type")),
            orgnummer = row.string("orgnr"),
            opprettetAv = row.string("opprettet_av"),
            saksnummer = row.string("saksnummer"),
            opprettetTidspunkt = row.localDateTime("opprettet"),
        )
    }
}
