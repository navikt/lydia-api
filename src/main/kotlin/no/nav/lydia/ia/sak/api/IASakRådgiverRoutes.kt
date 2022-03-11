package no.nav.lydia.ia.sak.api

import io.ktor.application.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.domene.SaksHendelsestype

val IA_SAK_RADGIVER_PATH = "iasak/radgiver"
val SAK_HENDELSE_SUB_PATH = "/hendelse"

fun Route.IASak_Rådgiver(
    iaSakRepository: IASakRepository
) {
    post("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH") {
        call.parameters["orgnummer"]?.let { orgnummer ->
            val hendelse = call.receive<SaksHendelsestype>()
            call.respondText {hendelse.name}
        } ?: call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i orgnummer")
    }
}

