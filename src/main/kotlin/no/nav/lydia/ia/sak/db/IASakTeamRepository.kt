package no.nav.lydia.ia.sak.db

import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import javax.sql.DataSource
import no.nav.lydia.ia.sak.domene.IASak

data class BrukerITeam (val ident: String, val saksnummer: String)

class IASakTeamRepository(val dataSource: DataSource) {

    fun leggBrukerTilTeam(iaSak: IASak, navAnsatt: NavAnsatt ) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        INSERT INTO ia_sak (
                            saksnummer,
                            ident
                        )
                        VALUES (
                            :saksnummer,
                            :ident
                        )
                        returning *                            
                    """.trimMargin(),
                    mapOf(
                        "saksnummer" to iaSak.saksnummer,
                        "ident" to navAnsatt.navIdent
                    )
                ).map { row ->
                    BrukerITeam(ident = row.string("ident"), saksnummer = row.string("saksnummer"))
                }.asSingle
            )
        }
}
