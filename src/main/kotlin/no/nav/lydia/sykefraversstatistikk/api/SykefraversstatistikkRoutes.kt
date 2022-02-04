package no.nav.lydia.sykefraversstatistikk.api

import io.ktor.application.*
import io.ktor.http.*
import io.ktor.response.*
import io.ktor.routing.*
import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService

val SYKEFRAVERSSTATISTIKK_PATH = "sykefraversstatistikk"
val FILTERVERDIER_PATH = "filterverdier"

fun Route.sykefraversstatistikk(sykefraversstatistikkRepository: SykefraversstatistikkRepository) {
    get("$SYKEFRAVERSSTATISTIKK_PATH/") {
        call.respond("OK")
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/{orgnummer}") {
        call.parameters["orgnummer"]?.let { orgnummer ->
            if (orgnummer == SykefraversstatistikkVirksomhetDto.dummySvar.orgnr) // TODO fjern når vi har data
                call.respond(listOf(SykefraversstatistikkVirksomhetDto.dummySvar))
            else
                call.respond(sykefraversstatistikkRepository.hentSykefravær(orgnummer).toDto())
        } ?:
            call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i orgnummer")
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH") {
        call.respond(FilterverdierDto(GeografiService().hentFylkerOgKommuner()))
    }
}