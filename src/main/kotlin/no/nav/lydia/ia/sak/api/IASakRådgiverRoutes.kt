package no.nav.lydia.ia.sak.api

import io.ktor.application.*
import io.ktor.auth.*
import io.ktor.auth.jwt.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import no.nav.lydia.Security.Companion.NAV_IDENT_CLAIM
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakstype

val IA_SAK_RADGIVER_PATH = "iasak/radgiver"
val SAK_HENDELSE_SUB_PATH = "/hendelse"

fun Route.IASak_Rådgiver(
    iaSakRepository: IASakRepository
) {
    post("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH") {
        val hendelse = call.receive<IASakshendelseDto>()
        call.principal<JWTPrincipal>()?.payload?.claims?.get(NAV_IDENT_CLAIM)?.asString()?.let { navIdent ->
            val sak = iaSakRepository.finnEllerOpprettSak(
                orgnr = hendelse.orgnummer,
                ident = navIdent,
                type = IASakstype.NAV_STOTTER
            )

            sak.behandleHendelse(IASakshendelse.fromDto(hendelse, navIdent))
            iaSakRepository.oppdaterSak(sak = sak)

            call.respond(sak.saksnummer)
        } ?: call.respond(status = HttpStatusCode.BadRequest, "Fant ikke NAVident for innlogget bruker")
    }
}

