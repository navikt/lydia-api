package no.nav.lydia.virksomhet.api

import arrow.core.rightIfNotNull
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.*
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.sykefraversstatistikk.api.SykefraværsstatistikkError
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somBrukerMedLesetilgang
import no.nav.lydia.virksomhet.VirksomhetRepository

const val VIRKSOMHET_PATH = "virksomhet"

fun Route.virksomhet(
    virksomhetRepository: VirksomhetRepository,
    auditLog: AuditLog,
    fiaRoller: FiaRoller
) {
    get("$VIRKSOMHET_PATH/{orgnummer}") {
        val orgnummer = call.parameters["orgnummer"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig orgnummer`)
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) {
            virksomhetRepository.hentVirksomhet(orgnr = orgnummer)?.toDto().rightIfNotNull { VirksomhetFeil.`fant ikke virksomhet` }
        }.map {
            auditLog(auditLog = auditLog, orgnummer = orgnummer, auditType = AuditType.access, tillat = Tillat.Ja)
            call.respond(HttpStatusCode.OK, it)
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }
}

object VirksomhetFeil {
    val `fant ikke virksomhet` = Feil(feilmelding = "Fant ingen virksomheter med gitt orgnummer", httpStatusCode = HttpStatusCode.NotFound)
}