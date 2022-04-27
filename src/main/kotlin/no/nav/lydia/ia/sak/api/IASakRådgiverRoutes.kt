package no.nav.lydia.ia.sak.api

import arrow.core.Either
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
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somSuperbruker

val IA_SAK_RADGIVER_PATH = "iasak/radgiver"
val SAK_HENDELSE_SUB_PATH = "/hendelse"
val SAK_HENDELSER_SUB_PATH = "/hendelser"

fun Route.IASak_Rådgiver(
    iaSakService: IASakService,
    fiaRoller: FiaRoller
) {
    post("$IA_SAK_RADGIVER_PATH/{orgnummer}") {
        val orgnummer = call.parameters["orgnummer"] ?: return@post call.respond(IASakError.`ugyldig orgnummer`)
        somSuperbruker(call = call, fiaRoller = fiaRoller) { superbruker ->
            iaSakService.opprettSakOgMerkSomVurdert(orgnummer, superbruker.navIdent)
        }.also {
            when (it) {
                is Either.Left -> call.respond(it.value.httpStatusCode)
                is Either.Right -> call.respond(HttpStatusCode.Created, it.value.toDto())
            }
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
    val `prøvde å legge til en hendelse på en tom sak` =
        Feil("Prøvde å legge til en hendelse på en tom sak", HttpStatusCode.Forbidden)
    val `prøvde å legge til en hendelse på en gammel sak` = Feil(
        "Prøvde å legge til hendelse på gammel sak", HttpStatusCode.Forbidden)
    val `fikk ikke oppdatert sak` = Feil("Fikk ikke oppdater sak", HttpStatusCode.Forbidden)
    val `ugyldig orgnummer` = Feil("Ugyldig orgnummer", HttpStatusCode.Forbidden)
}
