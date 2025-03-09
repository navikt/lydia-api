package no.nav.lydia.vedlikehold

import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.json.Json
import no.nav.lydia.ia.eksport.IASakLeveranseProdusent
import no.nav.lydia.ia.eksport.IASakLeveranseProdusent.IASakLeveranseValue
import no.nav.lydia.ia.sak.api.IASakLeveranseOppdateringsDto
import no.nav.lydia.ia.sak.db.IASakLeveranseRepository
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.Rolle
import java.time.LocalDateTime

class LukkAlleÅpneIaTjenester(
    val iaSakLeveranseRepository: IASakLeveranseRepository,
    val iaSakLeveranseProdusent: IASakLeveranseProdusent,
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
                    emptySet(),
                ),
            ).map { iaTjeneste ->
                val nøkkel = iaTjeneste.id.toString()
                val verdi = IASakLeveranseValue(
                    id = iaTjeneste.id,
                    saksnummer = iaTjeneste.saksnummer,
                    iaTjenesteId = iaTjeneste.modul.iaTjeneste.id,
                    iaTjenesteNavn = iaTjeneste.modul.iaTjeneste.navn,
                    iaModulId = iaTjeneste.modul.id,
                    iaModulNavn = iaTjeneste.modul.navn,
                    frist = iaTjeneste.frist.toKotlinLocalDate(),
                    status = IASakLeveranseStatus.LEVERT,
                    opprettetAv = iaTjeneste.opprettetAv,
                    sistEndret = LocalDateTime.now().toKotlinLocalDateTime(),
                    sistEndretAv = "Fia system",
                    sistEndretAvRolle = Rolle.SUPERBRUKER,
                    fullført = LocalDateTime.now().toKotlinLocalDateTime(),
                    enhetsnummer = IASakStatusOppdaterer.NAV_ENHET_FOR_TILBAKEFØRING.enhetsnummer,
                    enhetsnavn = IASakStatusOppdaterer.NAV_ENHET_FOR_TILBAKEFØRING.enhetsnavn,
                    opprettetTidspunkt = iaTjeneste.opprettetTidspunkt?.toKotlinLocalDateTime(),
                )

                iaSakLeveranseProdusent.sendMelding(nøkkel, Json.encodeToString(verdi))
            }
        }
    }
}
