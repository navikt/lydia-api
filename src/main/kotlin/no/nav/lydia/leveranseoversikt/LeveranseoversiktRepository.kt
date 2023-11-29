package no.nav.lydia.leveranseoversikt

import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.tilgangskontroll.NavAnsatt
import javax.sql.DataSource

class LeveranseoversiktRepository(val dataSource: DataSource) {
    fun hentLeveranser(saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle): List<LeveranseoversiktDto> {
        using(sessionOf(dataSource)) { session ->
            queryOf(
                """
                    select orgnr,
                           virksomhet.navn        as virksomhetsnavn,
                           frist                  as leveransefrist,
                           iasak_leveranse.status as leveransestatus,
                           modul.id               as modul_id,
                           modul.navn             as modulnavn,
                           modul.deaktivert       as modul_deaktivert,
                           ia_tjeneste.id         as iatjeneste_id,
                           ia_tjeneste.navn       as iatjenestenavn,
                           ia_tjeneste.deaktivert as iatjeneste_deaktivert
                    from ia_sak
                           join virksomhet using (orgnr)
                           join iasak_leveranse using (saksnummer)
                           join modul on iasak_leveranse.modul = modul.id
                           join ia_tjeneste on modul.ia_tjeneste = ia_tjeneste.id
                    where eid_av = $saksbehandler; 
                """.trimIndent()
            )
        }



        return emptyList()
    }





}
