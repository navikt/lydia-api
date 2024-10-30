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
            )

            iaSakLeveranseProdusent.sendMelding(
                it.id.toString(),
                IASakLeveranseProdusent.IASakLeveranseValue(
                    it.id,
                    it.saksnummer,
                    it.modul.iaTjeneste.id,
                    it.modul.iaTjeneste.navn,
                    it.modul.id,
                    it.modul.navn,
                    it.frist.toKotlinLocalDate(),
                    IASakLeveranseStatus.LEVERT,
                    it.opprettetAv,
                    java.time.LocalDateTime.now().toKotlinLocalDateTime(),
                    "Fia system",
                    Rolle.SUPERBRUKER,
                    java.time.LocalDateTime.now().toKotlinLocalDateTime(),
                    IASakStatusOppdaterer.NAV_ENHET_FOR_TILBAKEFØRING.enhetsnummer,
                    IASakStatusOppdaterer.NAV_ENHET_FOR_TILBAKEFØRING.enhetsnavn,
                    it.opprettetTidspunkt?.toKotlinLocalDateTime()
                )
            )
        }
    }
}
