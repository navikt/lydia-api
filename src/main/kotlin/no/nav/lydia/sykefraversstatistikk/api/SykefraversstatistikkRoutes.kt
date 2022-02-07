package no.nav.lydia.sykefraversstatistikk.api

import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.virksomhet.VirksomhetService

val SYKEFRAVERSSTATISTIKK_PATH = "sykefraversstatistikk"
val FILTERVERDIER_PATH = "filterverdier"

fun Route.sykefraversstatistikk(virksomhetService: VirksomhetService, geografiService: GeografiService) {
    get("$SYKEFRAVERSSTATISTIKK_PATH/") {
        val kommunenummerISøk = call.request.queryParameters["kommuner"]?.split(",")?.toSet() ?: emptySet()

        val alleKommuner = geografiService.hentKommuner().associateBy{ it.nummer }
        val gyldigeKommunenummerISøk = kommunenummerISøk.filter{
            kommunenummer -> alleKommuner.containsKey(kommunenummer)
        }
        val virksomheter = virksomhetService.hentVirksomheterFraFylkesnummer(gyldigeKommunenummerISøk)
        call.respond(virksomheter)
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/{orgnummer}") {
        call.respond(SykefraversstatistikkVirksomhetDto.dummySvar)
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH") {
        call.respond(FilterverdierDto(geografiService.hentFylkerOgKommuner()))
    }
}