package no.nav.lydia.statusoverikt.api

import arrow.core.right
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.statusoverikt.StatusoversiktResponsDto
import no.nav.lydia.statusoverikt.StatusoversiktService
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.søkeparametere
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somBrukerMedSaksbehandlertilgang

const val STATUSOVERSIKT_PATH = "statusoversikt"

fun Route.statusoversikt(
    geografiService: GeografiService,
    statusoversiktService: StatusoversiktService,
    auditLog: AuditLog,
    naisEnvironment: NaisEnvironment,
) {
    val fiaRoller = naisEnvironment.security.fiaRoller
    get("$STATUSOVERSIKT_PATH/") {
        somBrukerMedSaksbehandlertilgang(call = call, fiaRoller = fiaRoller) { saksbehandler ->
            call.request.søkeparametere(geografiService, rådgiver = saksbehandler)
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
