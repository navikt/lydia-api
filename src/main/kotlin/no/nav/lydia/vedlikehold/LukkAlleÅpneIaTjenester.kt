package no.nav.lydia.vedlikehold

import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ia.eksport.IASakLeveranseProdusent
import no.nav.lydia.ia.sak.api.IASakLeveranseOppdateringsDto
import no.nav.lydia.ia.sak.db.IASakLeveranseRepository
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.Rolle

class LukkAlleÅpneIaTjenester(
    val iaSakLeveranseRepository: IASakLeveranseRepository,
    val iaSakLeveranseProdusent: IASakLeveranseProdusent
) {
    fun kjør() {
        iaSakLeveranseRepository.hentAlleIASakLeveranser().filter {
            it.status == IASakLeveranseStatus.UNDER_ARBEID
        }.forEach {
            iaSakLeveranseRepository.oppdaterIASakLeveranse(
                it.id,
                IASakLeveranseOppdateringsDto(IASakLeveranseStatus.LEVERT),
                NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker(
                    "Fia system",
                    "Fia system",
                    "",
                    emptySet()
                )
            ).map { iaTjeneste ->
                iaSakLeveranseProdusent.sendMelding(
                    iaTjeneste.id.toString(),
                    IASakLeveranseProdusent.IASakLeveranseValue(
                        iaTjeneste.id,
                        iaTjeneste.saksnummer,
                        iaTjeneste.modul.iaTjeneste.id,
                        iaTjeneste.modul.iaTjeneste.navn,
                        iaTjeneste.modul.id,
                        iaTjeneste.modul.navn,
                        iaTjeneste.frist.toKotlinLocalDate(),
                        IASakLeveranseStatus.LEVERT,
                        iaTjeneste.opprettetAv,
                        java.time.LocalDateTime.now().toKotlinLocalDateTime(),
                        "Fia system",
                        Rolle.SUPERBRUKER,
                        java.time.LocalDateTime.now().toKotlinLocalDateTime(),
                        IASakStatusOppdaterer.NAV_ENHET_FOR_TILBAKEFØRING.enhetsnummer,
                        IASakStatusOppdaterer.NAV_ENHET_FOR_TILBAKEFØRING.enhetsnavn,
                        iaTjeneste.opprettetTidspunkt?.toKotlinLocalDateTime()
                    )
                )
            }


        }
    }
}
