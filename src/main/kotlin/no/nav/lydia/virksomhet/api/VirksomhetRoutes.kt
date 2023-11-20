package no.nav.lydia.virksomhet.api

import arrow.core.right
import arrow.core.rightIfNotNull
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.call
import io.ktor.server.application.log
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import kotlinx.datetime.Clock
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.integrasjoner.salesforce.SalesforceClient
import no.nav.lydia.sykefraværsstatistikk.api.SykefraværsstatistikkError
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.virksomhet.VirksomhetService

const val VIRKSOMHET_PATH = "virksomhet"
const val SALESFORCE_LENKE_PATH = "${VIRKSOMHET_PATH}/salesforce"

fun Route.virksomhet(
    virksomhetService: VirksomhetService,
    salesforceClient: SalesforceClient,
    auditLog: AuditLog,
    adGrupper: ADGrupper,
) {
    get("$VIRKSOMHET_PATH/{orgnummer}") {
        val orgnummer = call.parameters["orgnummer"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig orgnummer`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
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
        call.somLesebruker(adGrupper = adGrupper) {
            virksomhetService.finnVirksomheter(søkestreng = søkestreng).right()
        }.map {
            call.respond(it)
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$SALESFORCE_LENKE_PATH/{orgnummer}") {
        val nå = Clock.System.now()
        val orgnummer = call.parameters["orgnummer"] ?: return@get call.respond(SykefraværsstatistikkError.`ugyldig orgnummer`)

        salesforceClient.hentSalesforceUrl(orgnr = orgnummer).map { salesforceUrlResponse ->
            call.application.log.info("Hentet salesforce lenke for virksomhet på ${Clock.System.now() - nå} ms")
            call.respond(salesforceUrlResponse)
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }
}

object VirksomhetFeil {
    val `fant ikke virksomhet` = Feil(feilmelding = "Fant ingen virksomheter med gitt orgnummer", httpStatusCode = HttpStatusCode.NotFound)
    val `mangler søkestreng` = Feil(feilmelding = "Mangler søkestreng", httpStatusCode = HttpStatusCode.BadRequest)
}
