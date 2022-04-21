package no.nav.lydia.ia.sak.api

import arrow.core.Either
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.Security.Companion.NAV_IDENT_CLAIM
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IASakDto.Companion.toDto
import no.nav.lydia.ia.sak.api.IASakshendelseOppsummeringDto.Companion.toDto

val IA_SAK_RADGIVER_PATH = "iasak/radgiver"
val SAK_HENDELSE_SUB_PATH = "/hendelse"
val SAK_HENDELSER_SUB_PATH = "/hendelser"

fun Route.IASak_Rådgiver(
    iaSakService: IASakService
) {
    post("$IA_SAK_RADGIVER_PATH/{orgnummer}") {
        call.parameters["orgnummer"]?.let { orgnummer ->
            call.principal<JWTPrincipal>()?.payload?.claims?.get(NAV_IDENT_CLAIM)?.asString()?.let { navIdent ->
                when(val either = iaSakService.opprettSakOgMerkSomVurdert(orgnummer, navIdent)) {
                    is Either.Left -> call.respond(either.value.tilHTTPStatuskode())
                    is Either.Right -> call.respond(HttpStatusCode.Created, either.value.toDto())
                }
            }
        } ?: call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i orgnummer")
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
                is Either.Left -> call.respond(sakEither.value.tilHTTPStatuskode())
                is Either.Right -> call.respond(sakEither.value.toDto())
            }
        } ?: call.respond(status = HttpStatusCode.BadRequest, "Fant ikke NAVident for innlogget bruker")
    }
}


sealed class IASakError {
    object PrøvdeÅLeggeTilHendelsePåTomSak : IASakError()
    object PrøvdeÅLeggeTilHendelsePåGammelSak : IASakError()
    object FikkIkkeOppdatertSak : IASakError()

    fun tilHTTPStatuskode() =
        when (this) {
            PrøvdeÅLeggeTilHendelsePåTomSak -> HttpStatusCode.NotAcceptable
            PrøvdeÅLeggeTilHendelsePåGammelSak -> HttpStatusCode.Conflict
            FikkIkkeOppdatertSak -> HttpStatusCode.InternalServerError
        }
}
