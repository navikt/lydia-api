package no.nav.lydia.ia.sak.db

import com.github.guepardoapps.kulid.ULID
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.*
import java.time.LocalDateTime
import javax.sql.DataSource

class IASakshendelseRepository(val dataSource: DataSource) {

    fun opprettHendelse(hendelse : IASakshendelse) =
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
                        "id" to ULID.random(),
                        "saksnummer" to hendelse.saksnummer,
                        "orgnr" to hendelse.orgnummer,
                        "type" to hendelse.type,
                        "opprettet_av" to hendelse.opprettetAv,
                        "opprettet" to LocalDateTime.now()
                    )
                ).map(this::mapRow).asSingle
            )!!
        }

    private fun mapRow(row: Row): IASakshendelse {
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