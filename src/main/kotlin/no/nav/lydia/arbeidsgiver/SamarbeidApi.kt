package no.nav.lydia.arbeidsgiver

import io.ktor.http.HttpStatusCode
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.abc.api.orgnummer
import no.nav.lydia.abc.api.sendFeil
import no.nav.lydia.abc.felles.Feil
import no.nav.lydia.abc.samarbeid.IASamarbeidService

const val ARBEIDSGIVER_SAMARBEID_PATH = "api/arbeidsgiver/samarbeid"

fun Route.samarbeid(samarbeidService: IASamarbeidService) {
    get("$ARBEIDSGIVER_SAMARBEID_PATH/{orgnummer}") {
        val orgnr = call.orgnummer ?: return@get call.sendFeil(
            Feil(
                feilmelding = "Mangler organisasjonsnummer",
                httpStatusCode = HttpStatusCode.BadRequest,
            ),
        )
        samarbeidService.hentSamarbeidMedPubliserteDokumenter(orgnr = orgnr)
            .map {
                call.respond(status = HttpStatusCode.OK, message = it)
            }.mapLeft {
                call.sendFeil(it)
            }
    }
}
