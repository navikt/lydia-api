package no.nav.lydia.ia.team

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.call
import io.ktor.server.application.log
import io.ktor.server.response.respond
import io.ktor.server.routing.post
import io.ktor.server.routing.get
import io.ktor.server.routing.delete
import io.ktor.server.routing.Route
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.tilgangskontroll.somSaksbehandler

const val IA_SAK_TEAM_PATH = "iasak/team"
const val MINE_SAKER_PATH = "iasak/minesaker"

fun Route.iaSakTeam(
    iaTeamService: IATeamService,
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
    azureService: AzureService,
) {
    post("$IA_SAK_TEAM_PATH/{saksnummer}") {
        val saksnummer = call.parameters["saksnummer"] ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)
        val iaSak = iaSakService.hentIASak(saksnummer).fold(
            { feil -> return@post call.sendFeil(feil) },
            { iaSak -> iaSak }
        )

        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            return@somSaksbehandler iaTeamService.knyttBrukerTilSak(iaSak = iaSak, navAnsatt = saksbehandler)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = iaSak.orgnr,
                auditType = AuditType.update,
                saksnummer = saksnummer
            )
        }.onLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }.onRight {
            call.respond(status = HttpStatusCode.Created, message = it)
        }
    }

    delete("$IA_SAK_TEAM_PATH/{saksnummer}") {
        val saksnummer = call.parameters["saksnummer"] ?: return@delete call.sendFeil(IASakError.`ugyldig saksnummer`)
        val iaSak = iaSakService.hentIASak(saksnummer).fold(
            { feil -> return@delete call.sendFeil(feil) },
            { iaSak -> iaSak }
        )

        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            return@somSaksbehandler iaTeamService.fjernBrukerFraSak(iaSak = iaSak, navAnsatt = saksbehandler)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = iaSak.orgnr,
                auditType = AuditType.update,
                saksnummer = saksnummer
            )
        }.onLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }.onRight {
            call.respond(status = HttpStatusCode.Created, message = it)
        }
    }


    get(MINE_SAKER_PATH) {
        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            iaTeamService.hentSakerTilBruker(saksbehandler)
        }.onLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }.onRight {
            call.respond(status = HttpStatusCode.OK, message = it)
        }
    }

}
