package no.nav.lydia.arbeidsgiver

import io.ktor.http.HttpStatusCode
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import org.slf4j.LoggerFactory

const val ARBEIDSGIVER_SAMARBEID_PATH = "api/arbeidsgiver/samarbeid"

private val logger = LoggerFactory.getLogger("SamarbeidApi")

fun Route.samarbeid(samarbeidService: IASamarbeidService) {
    get("$ARBEIDSGIVER_SAMARBEID_PATH/{orgnummer}") {
        logger.info("Samarbeid API called!")
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
