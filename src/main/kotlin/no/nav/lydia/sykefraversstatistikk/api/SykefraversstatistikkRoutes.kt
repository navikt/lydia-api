package no.nav.lydia.sykefraversstatistikk.api

import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*

val SYKEFRAVERSSTATISTIKK_PATH = "sykefraversstatistikk"
val FILTERVERDIER_PATH = "filterverdier"

fun Route.sykefraversstatistikk() {
    get("$SYKEFRAVERSSTATISTIKK_PATH/") {
        call.respond("OK")
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/{orgnummer}") {
        call.respond("OK")
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH") {
        call.respond(FilterverdierDto())
    }

}