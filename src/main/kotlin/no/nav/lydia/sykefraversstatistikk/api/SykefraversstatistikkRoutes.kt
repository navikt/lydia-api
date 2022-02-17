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

fun Route.sykefraversstatistikk(
    geografiService: GeografiService,
    sykefraversstatistikkRepository: SykefraversstatistikkRepository
) {
    get("$SYKEFRAVERSSTATISTIKK_PATH/") {
        val fylkesnummerISøk = call.request.queryParameters["fylker"]?.split(",")?.toSet() ?: emptySet()
        val kommunenummerISøk = call.request.queryParameters["kommuner"]?.split(",")?.toSet() ?: emptySet()

        if (fylkesnummerISøk.isEmpty() && kommunenummerISøk.isEmpty()){
            return@get call.respond(sykefraversstatistikkRepository.hentAltSykefravær().toDto())
        }
        val gyldigeKommunenummerISøk = geografiService.hentKommunerFraFylkerOgKommuner(fylkesnummerISøk, kommunenummerISøk)
        val virksomheter = sykefraversstatistikkRepository.hentSykefraværIKommuner(gyldigeKommunenummerISøk).toDto()
        call.respond(virksomheter)
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
        call.respond(FilterverdierDto(geografiService.hentFylkerOgKommuner()))
    }
}