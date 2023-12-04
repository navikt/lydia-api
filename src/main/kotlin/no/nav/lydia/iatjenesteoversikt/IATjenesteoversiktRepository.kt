package no.nav.lydia.iatjenesteoversikt

import kotlinx.datetime.toKotlinLocalDate
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.IATjenesteDto
import no.nav.lydia.ia.sak.api.ModulDto
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.tilgangskontroll.NavAnsatt
import javax.sql.DataSource

class IATjenesteoversiktRepository(val dataSource: DataSource) {
    fun hentIATjenester(saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle): List<IATjenesteoversiktDto> {
        return using(sessionOf(dataSource)) { session ->
            session.run(
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
                    where eid_av = :navident
                    and iasak_leveranse.status = :leveransestatus; 
                """.trimIndent(),
                    mapOf(
                        "navident" to saksbehandler.navIdent,
                        "leveransestatus" to IASakLeveranseStatus.UNDER_ARBEID.name
                    )
                ).map(this::mapRowToIATjenesteoversikt).asList
            )
        }
    }


    private fun mapRowToIATjenesteoversikt(rad: Row): IATjenesteoversiktDto {
        return IATjenesteoversiktDto(
            orgnr = rad.string("orgnr"),
            virksomhetsnavn = rad.string("virksomhetsnavn"),
            iaTjeneste = IATjenesteDto(
                id = rad.int("iatjeneste_id"),
                navn = rad.string("iatjenestenavn"),
                deaktivert = rad.boolean("iatjeneste_deaktivert"),
            ),
            modul = ModulDto(
                id = rad.int("modul_id"),
                navn = rad.string("modulnavn"),
                iaTjeneste = rad.int("iatjeneste_id"),
                deaktivert = rad.boolean("modul_deaktivert"),
            ),
            tentativFrist = rad.localDate("leveransefrist").toKotlinLocalDate(),
            status = rad.string("leveransestatus"),
        )
    }

}
