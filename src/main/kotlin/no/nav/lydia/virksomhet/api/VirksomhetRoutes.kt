package no.nav.lydia.virksomhet.api

import arrow.core.rightIfNotNull
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.call
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.FiaRoller
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.sykefraversstatistikk.api.SykefraværsstatistikkError
import no.nav.lydia.tilgangskontroll.Rådgiver.Companion.somBrukerMedLesetilgang
import no.nav.lydia.virksomhet.VirksomhetService

const val VIRKSOMHET_PATH = "virksomhet"

fun Route.virksomhet(
    virksomhetService: VirksomhetService,
    auditLog: AuditLog,
    fiaRoller: FiaRoller
) {
    get("$VIRKSOMHET_PATH/{orgnummer}") {
        val orgnummer = call.parameters["orgnummer"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig orgnummer`)
        somBrukerMedLesetilgang(call = call, fiaRoller = fiaRoller) {
            virksomhetService.hentVirksomhet(orgnr = orgnummer)?.toDto().rightIfNotNull { VirksomhetFeil.`fant ikke virksomhet` }
        }.also {
            auditLog.auditloggEither(call = call, either = it, orgnummer = orgnummer, auditType = AuditType.access)
        }.map {
            call.respond(HttpStatusCode.OK, it)
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$VIRKSOMHET_PATH/finn") {
        val søkestreng = call.request.queryParameters["q"] ?: return@get call.respond(VirksomhetFeil.`mangler søkestreng`)
        val virksomheter = virksomhetService.finnVirksomheter(søkestreng = søkestreng)
        call.respond(HttpStatusCode.OK, virksomheter)
    }
}

object VirksomhetFeil {
    val `fant ikke virksomhet` = Feil(feilmelding = "Fant ingen virksomheter med gitt orgnummer", httpStatusCode = HttpStatusCode.NotFound)
    val `mangler søkestreng` = Feil(feilmelding = "Mangler søkestreng", httpStatusCode = HttpStatusCode.BadRequest)
}