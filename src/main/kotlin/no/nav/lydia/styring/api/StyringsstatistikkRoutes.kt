package no.nav.lydia.styring.api

import arrow.core.right
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.styring.StyringsstatistikkResponsDto
import no.nav.lydia.styring.StyringsstatistikkService
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.søkeparametere
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somSuperbruker

const val STYRINGSSTATISTIKK_PATH = "styringsstatistikk"

fun Route.styringsstatistikk(
    geografiService: GeografiService,
    styringsstatistikkService: StyringsstatistikkService,
    auditLog: AuditLog,
    naisEnvironment: NaisEnvironment,
) {
    val fiaRoller = naisEnvironment.security.fiaRoller
    get("$STYRINGSSTATISTIKK_PATH/") {
        somSuperbruker(call = call, fiaRoller = fiaRoller) { superbruker ->
            call.request.søkeparametere(geografiService, rådgiver = superbruker)
        }.also {
            auditLog.auditloggEither(call = call, either = it, orgnummer = null, auditType = AuditType.access,
                melding = it.orNull()?.toLogString(), severity = "INFO")
        }.map { søkeparametere ->
            styringsstatistikkService.søkEtterStyringsstatistikk(søkeparametere = søkeparametere)
        }.map { styringsstatistikkList ->
            call.respond(StyringsstatistikkResponsDto(data = styringsstatistikkList)).right()
        }.mapLeft { feil -> call.respond(status = feil.httpStatusCode, message = feil.feilmelding) }
    }

}
