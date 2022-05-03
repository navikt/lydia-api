package no.nav.fia.virksomhet.api

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.fia.AuditLog
import no.nav.fia.AuditType
import no.nav.fia.Tillat
import no.nav.fia.auditLog
import no.nav.fia.virksomhet.VirksomhetRepository

const val VIRKSOMHET_PATH = "virksomhet"

fun Route.virksomhet(virksomhetRepository: VirksomhetRepository, auditLog: AuditLog) {
    get("$VIRKSOMHET_PATH/{orgnr}") {
        call.parameters["orgnr"]?.let { orgnummer ->
            auditLog(auditLog = auditLog, orgnummer = orgnummer, auditType = AuditType.access, tillat = Tillat.Ja)
            when (val virksomhet = virksomhetRepository.hentVirksomhet(orgnr = orgnummer)?.toDto()) {
                null -> call.respond(HttpStatusCode.NotFound)
                else -> call.respond(HttpStatusCode.OK, virksomhet)
            }
        } ?: call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i orgnummer")
    }
}