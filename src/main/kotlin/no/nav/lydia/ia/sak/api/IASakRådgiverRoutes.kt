package no.nav.lydia.ia.sak.api

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.FiaRoller
import no.nav.lydia.Security.Companion.NAV_IDENT_CLAIM
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IASakDto.Companion.toDto
import no.nav.lydia.ia.sak.api.IASakshendelseOppsummeringDto.Companion.toDto
import no.nav.lydia.tilgangskontroll.Rådgiver

val IA_SAK_RADGIVER_PATH = "iasak/radgiver"
val SAK_HENDELSE_SUB_PATH = "/hendelse"
val SAK_HENDELSER_SUB_PATH = "/hendelser"

fun Route.IASak_Rådgiver(
    iaSakService: IASakService,
    fiaRoller: FiaRoller
) {
    post("$IA_SAK_RADGIVER_PATH/{orgnummer}") {
        val orgnummer = call.parameters["orgnummer"] ?: return@post call.respond(IASakError.UgyldigOrgnummer.httpStatusCode)
        val resultatEither = Rådgiver.from(call = call, fiaRoller = fiaRoller).flatMap { rådgiver: Rådgiver ->
            if (rådgiver.erSuperbruker()) iaSakService.opprettSakOgMerkSomVurdert(orgnummer, rådgiver.navIdent)
            else IASakError.IkkeAutorisert.left()
        }
        when (resultatEither) {
            is Either.Left -> call.respond(resultatEither.value.httpStatusCode)
            is Either.Right -> call.respond(resultatEither.value.toDto())
        }
    }

    get("$IA_SAK_RADGIVER_PATH/{orgnummer}") {
        call.parameters["orgnummer"]?.let { orgnummer ->
            call.respond(iaSakService.hentSaker(orgnummer).toDto())
        } ?: call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i orgnummer")
    }

    get("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSER_SUB_PATH/{saksnummer}") {
        call.parameters["saksnummer"]?.let { saksnummer ->
            call.respond(iaSakService.hentHendelserForSak(saksnummer).toDto())
        } ?: call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i hendelsene til denne saken")
    }

    post("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH") {
        val hendelseDto = call.receive<IASakshendelseDto>()
        call.principal<JWTPrincipal>()?.payload?.claims?.get(NAV_IDENT_CLAIM)?.asString()?.let { navIdent ->
            when (val sakEither = iaSakService.behandleHendelse(hendelseDto, navIdent)) {
                is Either.Left -> call.respond(sakEither.value.httpStatusCode, sakEither.value.feilmelding)
                is Either.Right -> call.respond(sakEither.value.toDto())
            }
        } ?: call.respond(status = HttpStatusCode.BadRequest, "Fant ikke NAVident for innlogget bruker")
    }
}

class Feil(val feilmelding: String, val httpStatusCode: HttpStatusCode)

object IASakError{
    val IkkeAutorisert = Feil("Feil", HttpStatusCode.Forbidden)
    val PrøvdeÅLeggeTilHendelsePåTomSak = Feil("Feil", HttpStatusCode.Forbidden)
    val PrøvdeÅLeggeTilHendelsePåGammelSak = Feil("Feil", HttpStatusCode.Forbidden)
    val FikkIkkeOppdatertSak = Feil("Feil", HttpStatusCode.Forbidden)
    val UgyldigOrgnummer = Feil("Feil", HttpStatusCode.Forbidden)
}
