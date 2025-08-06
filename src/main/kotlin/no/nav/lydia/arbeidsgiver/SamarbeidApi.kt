package no.nav.lydia.arbeidsgiver

import io.ktor.http.HttpStatusCode
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil

const val ARBEIDSGIVER_SAMARBEID_PATH = "api/arbeidsgiver/samarbeid"

fun Route.samarbeid() {
    get("$ARBEIDSGIVER_SAMARBEID_PATH/{orgnr}") {
        call.orgnummer ?: return@get call.sendFeil(
            Feil(
                feilmelding = "Mangler organisasjonsnummer",
                httpStatusCode = HttpStatusCode.BadRequest,
            ),
        )
    }
}
