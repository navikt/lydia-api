package no.nav.lydia.ia.sak.api

import io.ktor.server.application.call
import io.ktor.server.response.respond
import io.ktor.server.routing.post
import io.ktor.server.routing.Route
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASakTeamService
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.tilgangskontroll.somSaksbehandler

const val IA_SAK_TEAM_PATH = "iasak/team"

fun Route.iaSakTeam(
    iaSakTeamService: IASakTeamService,
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
    azureService: AzureService,
) {
    post("$IA_SAK_TEAM_PATH/{saksnummer}") {
        val saksnummer = call.parameters["saksnummer"] ?: return@post call.respond(IASakError.`ugyldig saksnummer`)
        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            iaSakService.hentIASak(saksnummer).onRight { iaSak ->
                return@somSaksbehandler iaSakTeamService.knyttBrukerTilSak(iaSak = iaSak, navAnsatt = saksbehandler)
            }
        }.onLeft {
            call.respond(it.httpStatusCode, it)
        }.onRight {
            call.respond(it)
        }
    }
}