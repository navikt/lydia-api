package no.nav.lydia.virksomhet.api

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.call
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.AuditType
import no.nav.lydia.Tilgang
import no.nav.lydia.auditLog
import no.nav.lydia.virksomhet.VirksomhetRepository

const val VIRKSOMHET_PATH = "virksomhet"

fun Route.virksomhet(virksomhetRepository: VirksomhetRepository) {
    get("$VIRKSOMHET_PATH/{orgnr}") {
        call.parameters["orgnr"]?.let { orgnr ->
            auditLog(orgnr = orgnr, auditType = AuditType.access, tilgang = Tilgang.Ja) // TODO: TILGANGSKONTROL
            when (val virksomhet = virksomhetRepository.hentVirksomhet(orgnr = orgnr)?.toDto()) {
                null -> call.respond(HttpStatusCode.NotFound)
                else -> call.respond(HttpStatusCode.OK, virksomhet)
            }
        } ?: call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i orgnummer")
    }
}