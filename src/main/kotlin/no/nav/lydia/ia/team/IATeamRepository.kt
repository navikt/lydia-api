package no.nav.lydia.ia.team

import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import javax.sql.DataSource

class IASakTeamRepository(val dataSource: DataSource) {
    fun brukereITeam(iaSak: IASak, navAnsatt: NavAnsatt) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT saksnummer, ident 
                        FROM ia_sak_team
                        WHERE saksnummer = :saksnummer 
                    """.trimMargin(),
                    mapOf(
                        "saksnummer" to iaSak.saksnummer,
                        "ident" to navAnsatt.navIdent
                    )
                ).map { row ->
                    BrukerITeamDto(
                        ident = row.string("ident"),
                        saksnummer = row.string("saksnummer")
                    )
                }.asList
            )
        }

    fun leggBrukerTilTeam(iaSak: IASak, navAnsatt: NavAnsatt) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        INSERT INTO ia_sak_team (
                            saksnummer,
                            ident
                        )
                        VALUES (
                            :saksnummer,
                            :ident
                        )
                        ON CONFLICT DO NOTHING
                        returning *                            
                    """.trimMargin(),
                    mapOf(
                        "saksnummer" to iaSak.saksnummer,
                        "ident" to navAnsatt.navIdent
                    )
                ).map { row ->
                    BrukerITeamDto(
                        ident = row.string("ident"),
                        saksnummer = row.string("saksnummer")
                    )
                }.asSingle
            )
        }

    fun slettBrukerFraTeam(iaSak: IASak, navAnsatt: NavAnsatt) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        DELETE FROM ia_sak_team
                        WHERE saksnummer = :saksnummer AND ident = :ident
                        returning *                            
                    """.trimMargin(),
                    mapOf(
                        "saksnummer" to iaSak.saksnummer,
                        "ident" to navAnsatt.navIdent
                    )
                ).map { row ->
                    BrukerITeamDto(
                        ident = row.string("ident"),
                        saksnummer = row.string("saksnummer")
                    )
                }.asSingle
            )
        }

    fun hentSakerTilBruker(navAnsatt: NavAnsatt) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                      SELECT sak.saksnummer, sak.status, sak.eid_av, sak.endret, v.orgnr, v.navn
                      FROM ia_sak AS sak
                      JOIN virksomhet AS v using (orgnr)
                      WHERE sak.eid_av = :navident                              
                    """.trimMargin(),
                    mapOf(
                        "navident" to navAnsatt.navIdent
                    )
                ).map { row ->
                    MineSakerDto(
                        saksnummer = row.string("saksnummer"),
                        status = IAProsessStatus.valueOf(row.string("status")),
                        orgnr = row.string("orgnr"),
                        orgnavn = row.string("navn"),
                        endretTidspunkt = row.localDateTimeOrNull("endret")?.toKotlinLocalDateTime(),
                        eidAv = row.stringOrNull("eid_av")
                    )
                }.asList
            )
        }
}
