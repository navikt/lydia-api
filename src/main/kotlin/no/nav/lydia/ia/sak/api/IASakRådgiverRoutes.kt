package no.nav.lydia.ia.sak.api

import io.ktor.application.*
import io.ktor.auth.*
import io.ktor.auth.jwt.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import no.nav.lydia.Security.Companion.NAV_IDENT_CLAIM
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.NyIASakshendelse
import no.nav.lydia.ia.sak.domene.IASakstype

val IA_SAK_RADGIVER_PATH = "iasak/radgiver"
val SAK_HENDELSE_SUB_PATH = "/hendelse"

fun Route.IASak_Rådgiver(
    iaSakService: IASakService
) {
    post("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH") {
        val hendelseDto = call.receive<IASakshendelseDto>()
        call.principal<JWTPrincipal>()?.payload?.claims?.get(NAV_IDENT_CLAIM)?.asString()?.let { navIdent ->
            val sak = iaSakService.behandleHendelse(hendelseDto, navIdent)
            call.respond(sak.saksnummer)
        } ?: call.respond(status = HttpStatusCode.BadRequest, "Fant ikke NAVident for innlogget bruker")
    }
}

