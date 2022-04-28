package no.nav.lydia.virksomhet.api

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.virksomhet.VirksomhetRepository

const val VIRKSOMHET_PATH = "virksomhet"

fun Route.virksomhet(virksomhetRepository: VirksomhetRepository) {
    get("$VIRKSOMHET_PATH/{orgnr}") {
        call.parameters["orgnr"]?.let { orgnr ->
            when (val virksomhet = virksomhetRepository.hentVirksomhet(orgnr = orgnr)?.toDto()) {
                null -> call.respond(HttpStatusCode.NotFound)
                else -> call.respond(HttpStatusCode.OK, virksomhet)
            }
        } ?: call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i orgnummer")
    }
}