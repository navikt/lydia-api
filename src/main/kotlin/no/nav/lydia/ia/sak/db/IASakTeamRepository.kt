package no.nav.lydia.ia.sak.db

import kotlinx.serialization.Serializable
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import javax.sql.DataSource
import no.nav.lydia.ia.sak.domene.IASak

@Serializable
data class BrukerITeamDto (val ident: String, val saksnummer: String)

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
                    BrukerITeamDto(ident = row.string("ident"), saksnummer = row.string("saksnummer"))
                }.asSingle
            )
        }
}
