package no.nav.lydia.ia.sak.db

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import no.nav.lydia.tilgangskontroll.Rådgiver
import org.slf4j.Logger
import org.slf4j.LoggerFactory
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
                        opprettet_av_rolle,
                        saksnummer,
                        opprettet,
                        aarsak_enum,
                        array_agg(begrunnelse_enum) as begrunnelser
                    FROM ia_sak_hendelse
                    LEFT JOIN hendelse_begrunnelse ON (ia_sak_hendelse.id = hendelse_begrunnelse.hendelse_id) 
                    WHERE saksnummer = :saksnummer
                    GROUP BY aarsak_enum, id, type, orgnr, opprettet_av, saksnummer, opprettet
                    ORDER BY opprettet ASC
                    """.trimIndent(),
                    mapOf(
                        "saksnummer" to saksnummer
                    )
                )
                    .map(this::mapRow).asList
            )
        }.verifiserAtViIkkeHarDuplikater()

    fun hentHendelserForOrgnummer(orgnr: String): List<IASakshendelse> {
        val orgnrKolonneNavn = "orgnr"
        return using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT 
                        id,
                        type,
                        $orgnrKolonneNavn,
                        opprettet_av,
                        opprettet_av_rolle,
                        saksnummer,
                        opprettet,
                        aarsak_enum,
                        array_agg(begrunnelse_enum) as begrunnelser
                    FROM ia_sak_hendelse
                    LEFT JOIN hendelse_begrunnelse ON (ia_sak_hendelse.id = hendelse_begrunnelse.hendelse_id) 
                    WHERE $orgnrKolonneNavn = :$orgnrKolonneNavn
                    GROUP BY aarsak_enum, id, type, $orgnrKolonneNavn, opprettet_av, saksnummer, opprettet
                    ORDER BY opprettet ASC
                    """.trimIndent(),
                    mapOf(
                        orgnrKolonneNavn to orgnr
                    )
                )
                    .map(this::mapRow).asList
            )
        }.verifiserAtViIkkeHarDuplikater()
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
                        opprettet_av_rolle,
                        opprettet
                    )
                    VALUES (
                        :id,
                        :saksnummer,
                        :orgnr,
                        :type,
                        :opprettet_av,
                        :opprettet_av_rolle,
                        :opprettet
                    ) 
                """.trimMargin(),
                    mapOf(
                        "id" to hendelse.id,
                        "saksnummer" to hendelse.saksnummer,
                        "orgnr" to hendelse.orgnummer,
                        "type" to hendelse.hendelsesType.name,
                        "opprettet_av" to hendelse.opprettetAv,
                        "opprettet_av_rolle" to hendelse.opprettetAvRolle?.toString(),
                        "opprettet" to hendelse.opprettetTidspunkt
                    )
                ).asUpdate
            )
            hendelse
        }

    fun hentHendelse(hendelseId: String): IASakshendelse? {
        val idKolonneNavn = "id"
        return using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT 
                        $idKolonneNavn,
                        type,
                        orgnr,
                        opprettet_av,
                        opprettet_av_rolle,
                        saksnummer,
                        opprettet,
                        aarsak_enum,
                        array_agg(begrunnelse_enum) as begrunnelser
                    FROM ia_sak_hendelse
                    LEFT JOIN hendelse_begrunnelse ON (ia_sak_hendelse.id = hendelse_begrunnelse.hendelse_id) 
                    WHERE $idKolonneNavn = :$idKolonneNavn
                    GROUP BY id, aarsak_enum
                    """.trimIndent(),
                    mapOf(
                        idKolonneNavn to hendelseId
                    )
                )
                    .map(this::mapRow).asSingle
            )
        }
    }

    private fun mapRow(row: Row): IASakshendelse {
        val valgtÅrsak = årsakFraDatabase(row.stringOrNull("aarsak_enum"), row.array("begrunnelser"))
            ?: return IASakshendelse(
                id = row.string("id"),
                opprettetTidspunkt = row.localDateTime("opprettet"),
                saksnummer = row.string("saksnummer"),
                hendelsesType = IASakshendelseType.valueOf(row.string("type")),
                orgnummer = row.string("orgnr"),
                opprettetAv = row.string("opprettet_av"),
                opprettetAvRolle = row.stringOrNull("opprettet_av_rolle")?.let { Rådgiver.Rolle.valueOf(it) }
            )
        return VirksomhetIkkeAktuellHendelse(
            id = row.string("id"),
            opprettetTidspunkt = row.localDateTime("opprettet"),
            saksnummer = row.string("saksnummer"),
            orgnummer = row.string("orgnr"),
            opprettetAv = row.string("opprettet_av"),
            opprettetAvRolle = row.stringOrNull("opprettet_av_rolle")?.let { Rådgiver.Rolle.valueOf(it) },
            valgtÅrsak = valgtÅrsak,
        )
    }

    private fun årsakFraDatabase(årsak: String?, begrunnelser: Array<String?>) =
        årsak?.let {
            val valgtÅrsak = ÅrsakType.valueOf(it)
            val valgtBegrunnelser = begrunnelser.filterNotNull().map(BegrunnelseType::valueOf)
            ValgtÅrsak(type = valgtÅrsak, begrunnelser = valgtBegrunnelser)
        }

    companion object {
        private val logger: Logger = LoggerFactory.getLogger(this::class.java)

        private fun List<IASakshendelse>.verifiserAtViIkkeHarDuplikater(): List<IASakshendelse> {
            val listSize = this.size
            if (listSize >= 2) {
                val nestSiste = this[listSize - 2]
                val siste = this.last()
                if (siste.hendelsesType != IASakshendelseType.TILBAKE && siste.opprettetAv == nestSiste.opprettetAv && siste.hendelsesType == nestSiste.hendelsesType) {
                    logger.warn("Feil! IASak ${siste.saksnummer} har doble hendelser i databasen med følgende ider: ${nestSiste.id} ${siste.id}")
                    throw IllegalStateException("IASak ${siste.saksnummer} har doble hendelser i databasen med følgende ider: ${nestSiste.id} ${siste.id}")
                }
            }
            return this
        }
    }
}
