package no.nav.lydia.ia.sak.api

import arrow.core.Either
import io.ktor.application.*
import io.ktor.auth.*
import io.ktor.auth.jwt.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import no.nav.lydia.Security.Companion.NAV_IDENT_CLAIM
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IASakDto.Companion.toDto

val IA_SAK_RADGIVER_PATH = "iasak/radgiver"
val SAK_HENDELSE_SUB_PATH = "/hendelse"

fun Route.IASak_Rådgiver(
    iaSakService: IASakService
) {
    post("$IA_SAK_RADGIVER_PATH/{orgnummer}") {
        call.parameters["orgnummer"]?.let { orgnummer ->
            call.principal<JWTPrincipal>()?.payload?.claims?.get(NAV_IDENT_CLAIM)?.asString()?.let { navIdent ->
                call.respond(iaSakService.opprettSak(orgnummer, navIdent).toDto())
            }
        } ?: call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i orgnummer")
    }

    get("$IA_SAK_RADGIVER_PATH/{orgnummer}") {
        call.parameters["orgnummer"]?.let { orgnummer ->
            call.respond(iaSakService.hentSaker(orgnummer).toDto())
        } ?: call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i orgnummer")
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
    object FikkIkkeOppdatertSak : IASakError()

    fun tilHTTPStatuskode() =
        when (this) {
            is PrøvdeÅLeggeTilHendelsePåTomSak -> HttpStatusCode.NotAcceptable
            is FikkIkkeOppdatertSak -> HttpStatusCode.InternalServerError
        }
}
