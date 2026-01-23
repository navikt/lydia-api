package no.nav.lydia.ia.team

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.log
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.delete
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.appstatus.Metrics.Companion.loggFølging
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.tilgangskontroll.somLesebruker

const val IA_SAK_TEAM_PATH = "iasak/team"
const val MINE_SAKER_PATH = "iasak/minesaker"

fun Route.iaSakTeam(
    iaTeamService: IATeamService,
    iaSakService: IASakService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    get("$IA_SAK_TEAM_PATH/{saksnummer}") {
        val saksnummer = call.parameters["saksnummer"] ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val iaSakDto = iaSakService.hentIASakDto(saksnummer).fold(
            { feil -> return@get call.sendFeil(feil) },
            { iaSak -> iaSak },
        )

        call.somLesebruker(adGrupper = adGrupper) {
            iaTeamService.hentBrukereITeam(iaSakDto)
        }.onLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }.onRight {
            call.respond(status = HttpStatusCode.OK, message = it)
        }
    }

    post("$IA_SAK_TEAM_PATH/{saksnummer}") {
        val saksnummer = call.parameters["saksnummer"] ?: return@post call.sendFeil(IASakError.`ugyldig saksnummer`)
        val iaSakDto = iaSakService.hentIASakDto(saksnummer).fold(
            { feil -> return@post call.sendFeil(feil) },
            { iASakDto -> iASakDto },
        )

        call.somLesebruker(adGrupper = adGrupper) { lesebruker ->
            return@somLesebruker iaTeamService.knyttBrukerTilSak(iaSakDto = iaSakDto, navAnsatt = lesebruker)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = iaSakDto.orgnr,
                auditType = AuditType.update,
                saksnummer = saksnummer,
            )
        }.onLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }.onRight {
            loggFølging(true)
            call.respond(status = HttpStatusCode.Created, message = it)
        }
    }

    delete("$IA_SAK_TEAM_PATH/{saksnummer}") {
        val saksnummer = call.parameters["saksnummer"] ?: return@delete call.sendFeil(IASakError.`ugyldig saksnummer`)
        val iaSakDto = iaSakService.hentIASakDto(saksnummer).fold(
            { feil -> return@delete call.sendFeil(feil) },
            { iaSak -> iaSak },
        )

        call.somLesebruker(adGrupper = adGrupper) { lesebruker ->
            return@somLesebruker iaTeamService.fjernBrukerFraSak(iaSakDto = iaSakDto, navAnsatt = lesebruker)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = iaSakDto.orgnr,
                auditType = AuditType.update,
                saksnummer = saksnummer,
            )
        }.onLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }.onRight {
            loggFølging(false)
            call.respond(status = HttpStatusCode.Created, message = it)
        }
    }

    get(MINE_SAKER_PATH) {
        call.somLesebruker(adGrupper = adGrupper) { lesebruker ->
            iaTeamService.hentSakerTilBruker(lesebruker).map {
                it.map { (iasak, orgnavn) ->
                    MineSakerDto(
                        iaSak = iasak,
                        orgnavn = orgnavn,
                    )
                }
            }
        }.onLeft {
            call.application.log.error(it.feilmelding)
            call.sendFeil(it)
        }.onRight {
            call.respond(status = HttpStatusCode.OK, message = it)
        }
    }
}
