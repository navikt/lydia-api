package no.nav.lydia.statusoversikt.api

import arrow.core.right
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.statusoversikt.StatusoversiktResponsDto
import no.nav.lydia.statusoversikt.StatusoversiktService
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.søkeparametere
import no.nav.lydia.sykefraværsstatistikk.api.geografi.GeografiService
import no.nav.lydia.tilgangskontroll.somLesebruker

const val STATUSOVERSIKT_PATH = "statusoversikt"

fun Route.statusoversikt(
    geografiService: GeografiService,
    statusoversiktService: StatusoversiktService,
    auditLog: AuditLog,
    naisEnvironment: NaisEnvironment,
) {
    val adGrupper = naisEnvironment.security.adGrupper
    get("$STATUSOVERSIKT_PATH/") {
        call.somLesebruker(adGrupper = adGrupper) { saksbehandler ->
            call.request.søkeparametere(geografiService, navAnsatt = saksbehandler)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = null,
                auditType = AuditType.access,
                melding = it.getOrNull()?.toLogString(),
                severity = "INFO",
            )
        }.map { søkeparametere ->
            statusoversiktService.søkEtterStatusoversikt(søkeparametere = søkeparametere)
        }.map { statusoversiktList ->
            call.respond(StatusoversiktResponsDto(data = statusoversiktList)).right()
        }.mapLeft { feil -> call.respond(status = feil.httpStatusCode, message = feil.feilmelding) }
    }
}
