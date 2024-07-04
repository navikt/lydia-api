package no.nav.lydia.ia.sak.db

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IAProsessStatus
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
    val status: IAProsessStatus,
    val orgnr: String,
    val orgnavn: String,
    val eidAv: String?,
    val endretTidspunkt: LocalDateTime?,
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
