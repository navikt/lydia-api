package no.nav.lydia.ia.team

import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.tilIASak
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import javax.sql.DataSource

class IATeamRepository(
    val dataSource: DataSource,
) {
    fun brukereITeam(
        iaSak: IASak,
        navAnsatt: NavAnsatt,
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                        SELECT saksnummer, ident 
                        FROM ia_sak_team
                        WHERE saksnummer = :saksnummer 
                """.trimMargin(),
                mapOf(
                    "saksnummer" to iaSak.saksnummer,
                    "ident" to navAnsatt.navIdent,
                ),
            ).map { row ->
                row.string("ident")
            }.asList,
        )
    }

    fun leggBrukerTilTeam(
        iaSak: IASak,
        navAnsatt: NavAnsatt,
    ) = using(sessionOf(dataSource)) { session ->
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
                    "ident" to navAnsatt.navIdent,
                ),
            ).map { row ->
                BrukerITeamDto(
                    ident = row.string("ident"),
                    saksnummer = row.string("saksnummer"),
                )
            }.asSingle,
        )
    }

    fun slettBrukerFraTeam(
        iaSak: IASak,
        navAnsatt: NavAnsatt,
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                        DELETE FROM ia_sak_team
                        WHERE saksnummer = :saksnummer AND ident = :ident
                        returning *                            
                """.trimMargin(),
                mapOf(
                    "saksnummer" to iaSak.saksnummer,
                    "ident" to navAnsatt.navIdent,
                ),
            ).map { row ->
                BrukerITeamDto(
                    ident = row.string("ident"),
                    saksnummer = row.string("saksnummer"),
                )
            }.asSingle,
        )
    }

    fun hentSakerBrukerEierEllerFølger(navAnsatt: NavAnsatt) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT sak.*, v.navn
                        FROM ia_sak AS sak
                            JOIN virksomhet AS v USING (orgnr)
                            LEFT JOIN (
                                SELECT saksnummer, ident
                                FROM ia_sak_team
                                WHERE ident = :navident
                            ) AS iat USING (saksnummer) 
                        WHERE sak.eid_av = :navident 
                           OR iat.ident  = :navident
                    """.trimMargin(),
                    mapOf(
                        "navident" to navAnsatt.navIdent,
                    ),
                ).map { row ->
                    Pair(row.tilIASak(), row.string("navn"))
                }.asList,
            )
        }
}
