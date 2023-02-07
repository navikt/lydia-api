package no.nav.lydia.lederstatistikk.api

import arrow.core.right
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.lederstatistikk.LederstatistikkResponsDto
import no.nav.lydia.lederstatistikk.LederstatistikkService
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.søkeparametere
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somSuperbruker

const val LEDERSTATISTIKK_PATH = "lederstatistikk"

fun Route.lederstatistikk(
    geografiService: GeografiService,
    lederstatistikkService: LederstatistikkService,
    auditLog: AuditLog,
    naisEnvironment: NaisEnvironment,
) {
    val fiaRoller = naisEnvironment.security.fiaRoller
    get("$LEDERSTATISTIKK_PATH/") {
        somSuperbruker(call = call, fiaRoller = fiaRoller) { superbruker ->
            call.request.søkeparametere(geografiService, rådgiver = superbruker)
        }.also {
            auditLog.auditloggEither(call = call, either = it, orgnummer = null, auditType = AuditType.access,
                melding = it.orNull()?.toLogString(), severity = "INFO")
        }.map { søkeparametere ->
            lederstatistikkService.søkEtterLederstatistikk(søkeparametere = søkeparametere)
        }.map { lederstatistikkList ->
            call.respond(LederstatistikkResponsDto(data = lederstatistikkList)).right()
        }.mapLeft { feil -> call.respond(status = feil.httpStatusCode, message = feil.feilmelding) }
    }

}
