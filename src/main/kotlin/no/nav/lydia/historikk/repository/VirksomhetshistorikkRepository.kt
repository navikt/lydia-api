package no.nav.lydia.historikk.repository

import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.historikk.model.HistorikkHendelse
import no.nav.lydia.historikk.model.Årsak
import no.nav.lydia.samarbeidsperiode.BegrunnelseType
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import javax.sql.DataSource

class VirksomhetshistorikkRepository(
    private val dataSource: DataSource,
) {
    fun hentVirksomhetHendelser(orgnr: String): List<HistorikkHendelse> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT iah.id, iah.type, iah.opprettet, iah.saksnummer, iah.resulterende_status, iah.opprettet_av,
                           ha.aarsak, array_agg(ab.begrunnelse_enum) as begrunnelser
                    FROM ia_sak_hendelse iah 
                    LEFT JOIN hendelse_aarsak ha ON iah.id = ha.hendelse_id
                    LEFT JOIN aarsak_begrunnelse ab USING (aarsak_id)
                    WHERE iah.orgnr = :orgnr AND iah.type = ANY(:typer)
                    GROUP BY iah.id, iah.opprettet, ha.aarsak_id, ha.aarsak, ha.aarsak_enum, iah.type, iah.saksnummer, iah.resulterende_status,
                    iah.opprettet_av
                    ORDER BY opprettet
                    """.trimIndent(),
                    mapOf("orgnr" to orgnr, "typer" to virksomhetshendelsestyper.map { it.name }.toTypedArray()),
                ).map { row ->
                    HistorikkHendelse(
                        hendelseId = row.string("id"),
                        hendelsetype = IASakshendelseType.valueOf(row.string("type")),
                        resulterendeStatus = IASak.Status.valueOf(row.string("resulterende_status")),
                        tidspunkt = row.localDateTime("opprettet").toKotlinLocalDateTime(),
                        hendelseOpprettetAv = row.string("opprettet_av"),
                        årsak = row.stringOrNull("aarsak")?.let { beskrivelse ->
                            Årsak(
                                beskrivelse = beskrivelse,
                                begrunnelser = row.array<String>("begrunnelser").filterNotNull()
                                    .map { BegrunnelseType.valueOf(it).navn },
                            )
                        },
                    )
                }.asList,
            )
        }

    companion object {
        val virksomhetshendelsestyper: Set<IASakshendelseType> = setOf(IASakshendelseType.VIRKSOMHET_AVREGISTRERT)
    }
}
