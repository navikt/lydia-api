package no.nav.lydia.sykefraversstatistikk.api

import io.ktor.application.*
import io.ktor.http.*
import io.ktor.response.*
import io.ktor.routing.*
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.virksomhet.VirksomhetService

val SYKEFRAVERSSTATISTIKK_PATH = "sykefraversstatistikk"
val FILTERVERDIER_PATH = "filterverdier"

fun Route.sykefraversstatistikk() {
    val virksomhetService = VirksomhetService()
    val geografiService = GeografiService()


    get("$SYKEFRAVERSSTATISTIKK_PATH/") {
        val fylkesNummerISøk = call.request.queryParameters["fylke"]?.split(",")?.toSet() ?: emptySet()

        val alleFylker = geografiService.hentFylker().associateBy{ it.nummer }
        val virksomheter = virksomhetService.hentVirksomheterFraFylkesnummer(fylkesNummerISøk.filter{
            fylkesnummer -> alleFylker.containsKey(fylkesnummer)
        })
        call.respond(virksomheter)

//      /api?fylke=Viken,Vestland&
//
//
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/{orgnummer}") {
        call.respond(SykefraversstatistikkVirksomhetDto.dummySvar)
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH") {
        call.respond(FilterverdierDto(geografiService.hentFylkerOgKommuner()))
    }
}