package no.nav.lydia.leveranseoversikt.api

import arrow.core.right
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.leveranseoversikt.LeveranseoversiktService
import no.nav.lydia.tilgangskontroll.innloggetNavIdent
import no.nav.lydia.tilgangskontroll.somSaksbehandler

const val LEVERANSEOVERSIKT_PATH = "leveranseoversikt"
const val MINE_LEVERANSER_PATH = "mine-leveranser"

fun Route.leveranseoversikt(
    leveranseoversiktService: LeveranseoversiktService,
    auditLog: AuditLog,
    naisEnvironment: NaisEnvironment,
) {
    val adGrupper = naisEnvironment.security.adGrupper
    get("$LEVERANSEOVERSIKT_PATH/$MINE_LEVERANSER_PATH") {
        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            leveranseoversiktService.hentMineLeveranser(saksbehandler = saksbehandler)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = null,
                auditType = AuditType.access,
                melding = if (it.isRight()) "Henter leveranser som er under arbeid og eies av: ${call.innloggetNavIdent()}" else "",
                severity = "INFO"
            )
        }.map { mineLeveranser ->
            call.respond(mineLeveranser).right()
        }.mapLeft { feil -> call.respond(status = feil.httpStatusCode, message = feil.feilmelding) }
    }
}
