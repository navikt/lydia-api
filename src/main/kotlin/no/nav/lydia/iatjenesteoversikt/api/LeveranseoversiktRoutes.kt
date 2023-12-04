package no.nav.lydia.iatjenesteoversikt.api

import arrow.core.right
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.iatjenesteoversikt.IATjenesteoversiktService
import no.nav.lydia.tilgangskontroll.innloggetNavIdent
import no.nav.lydia.tilgangskontroll.somSaksbehandler

const val IATJENESTEOVERSIKT_PATH = "iatjenesteoversikt"
const val MINE_IATJENESTER_PATH = "mine-iatjenester"

fun Route.iaTjenesteoversikt(
    iaTjenesteoversiktService: IATjenesteoversiktService,
    auditLog: AuditLog,
    naisEnvironment: NaisEnvironment,
) {
    val adGrupper = naisEnvironment.security.adGrupper
    get("$IATJENESTEOVERSIKT_PATH/$MINE_IATJENESTER_PATH") {
        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            iaTjenesteoversiktService.hentMineIATjenester(saksbehandler = saksbehandler)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = null,
                auditType = AuditType.access,
                melding = if (it.isRight()) "Henter IA-tjenestene som er under arbeid og eies av: ${call.innloggetNavIdent()}" else "",
                severity = "INFO"
            )
        }.map { mineIATjenester ->
            call.respond(mineIATjenester).right()
        }.mapLeft { feil -> call.respond(status = feil.httpStatusCode, message = feil.feilmelding) }
    }
}
