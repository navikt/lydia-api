package no.nav.lydia.ia.sak.db

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import no.nav.lydia.sykefraversstatistikk.api.geografi.NavEnheter
import javax.sql.DataSource

class IASakshendelseRepository(val dataSource: DataSource) {

    fun hentHendelserForSaksnummer(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT 
                        id,
                        type,
                        orgnr,
                        opprettet_av,
                        saksnummer,
                        opprettet,
                        aarsak_enum,
                        array_agg(begrunnelse_enum) as begrunnelser
                    FROM ia_sak_hendelse
                    LEFT JOIN hendelse_begrunnelse ON (ia_sak_hendelse.id = hendelse_begrunnelse.hendelse_id) 
                    WHERE saksnummer = :saksnummer
                    AND orgnr NOT in ${
                        NavEnheter.enheterSomSkalSkjermes.joinToString(
                            prefix = "(",
                            postfix = ")",
                            separator = ","
                        ) { s -> "\'$s\'" }
                    }
                    GROUP BY aarsak_enum, id, type, orgnr, opprettet_av, saksnummer, opprettet
                    ORDER BY id ASC
                    """.trimIndent(),
                    mapOf(
                        "saksnummer" to saksnummer
                    )
                )
                    .map(this::mapRow).asList
            )
        }
    
    fun lagreHendelse(hendelse: IASakshendelse) =
        using(sessionOf(dataSource)) { session ->
            session.run(
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
                """.trimMargin(),
                    mapOf(
                        "id" to hendelse.id,
                        "saksnummer" to hendelse.saksnummer,
                        "orgnr" to hendelse.orgnummer,
                        "type" to hendelse.hendelsesType.name,
                        "opprettet_av" to hendelse.opprettetAv,
                        "opprettet" to hendelse.opprettetTidspunkt
                    )
                ).asUpdate
            )
            hendelse
        }

    private fun mapRow(row: Row): IASakshendelse {
        val valgtÅrsak = årsakFraDatabase(row.stringOrNull("aarsak_enum"), row.array("begrunnelser"))
            ?: return IASakshendelse(
                id = row.string("id"),
                hendelsesType = SaksHendelsestype.valueOf(row.string("type")),
                orgnummer = row.string("orgnr"),
                opprettetAv = row.string("opprettet_av"),
                saksnummer = row.string("saksnummer"),
                opprettetTidspunkt = row.localDateTime("opprettet"),
            )
        return VirksomhetIkkeAktuellHendelse(
            id = row.string("id"),
            orgnummer = row.string("orgnr"),
            opprettetAv = row.string("opprettet_av"),
            saksnummer = row.string("saksnummer"),
            opprettetTidspunkt = row.localDateTime("opprettet"),
            valgtÅrsak = valgtÅrsak
        )
    }

    private fun årsakFraDatabase(årsak: String?, begrunnelser: Array<String?>) =
        årsak?.let {
            val valgtÅrsak = ÅrsakType.valueOf(it)
            val valgtBegrunnelser = begrunnelser.filterNotNull().map(BegrunnelseType::valueOf)
            ValgtÅrsak(type = valgtÅrsak, begrunnelser = valgtBegrunnelser)
        }
}
