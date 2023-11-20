package no.nav.lydia.statusoversikt.api

import arrow.core.right
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.statusoversikt.StatusoversiktResponsDto
import no.nav.lydia.statusoversikt.StatusoversiktService
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.søkeparametere
import no.nav.lydia.sykefraværsstatistikk.api.geografi.GeografiService
import no.nav.lydia.tilgangskontroll.somSaksbehandler

const val STATUSOVERSIKT_PATH = "statusoversikt"

fun Route.statusoversikt(
    geografiService: GeografiService,
    statusoversiktService: StatusoversiktService,
    auditLog: AuditLog,
    naisEnvironment: NaisEnvironment,
) {
    val adGrupper = naisEnvironment.security.adGrupper
    get("$STATUSOVERSIKT_PATH/") {
        call.somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
            call.request.søkeparametere(geografiService, navAnsatt = saksbehandler)
        }.also {
            auditLog.auditloggEither(call = call, either = it, orgnummer = null, auditType = AuditType.access,
                melding = it.orNull()?.toLogString(), severity = "INFO")
        }.map { søkeparametere ->
            statusoversiktService.søkEtterStatusoversikt(søkeparametere = søkeparametere)
        }.map { statusoversiktList ->
            call.respond(StatusoversiktResponsDto(data = statusoversiktList)).right()
        }.mapLeft { feil -> call.respond(status = feil.httpStatusCode, message = feil.feilmelding) }
    }

}
