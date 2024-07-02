package no.nav.lydia.ia.sak.db

import kotlinx.serialization.Serializable
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import javax.sql.DataSource
import no.nav.lydia.ia.sak.domene.IASak

@Serializable
data class BrukerITeamDto (
    val ident: String,
    val saksnummer: String
)
@Serializable
data class MineSakerDto (
    val saksnummer: String,
    val status: String,
    val orgnr: String,
    val orgnavn: String
)

class IASakTeamRepository(val dataSource: DataSource) {

    fun leggBrukerTilTeam(iaSak: IASak, navAnsatt: NavAnsatt ) =
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

    fun hentSakerTilBruker(navAnsatt: NavAnsatt) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                      SELECT ia_sak.saksnummer, ia_sak.status, virksomhet.orgnr, virksomhet.navn 
                      FROM ia_sak
                      JOIN virksomhet using (orgnr)
                      WHERE ia_sak.eid_av = :navident                              
                    """.trimMargin(),
                    mapOf(
                        "navident" to navAnsatt.navIdent
                    )
                ).map { row ->
                    MineSakerDto(
                        saksnummer = row.string("saksnummer"),
                        status = row.string("status"),
                        orgnr = row.string("orgnr"),
                        orgnavn = row.string("navn")
                    )
                }.asList
            )
        }

}
