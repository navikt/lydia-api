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
        val søkeparametere = Søkeparametere.from(call.request.queryParameters)

        if (søkeparametere.erTom()){
            return@get call.respond(sykefraversstatistikkRepository.hentAltSykefravær(søkeparametere).toDto())
        }

        val gyldigeKommunenummerISøk = geografiService.hentKommunerFraFylkerOgKommuner(
            søkeparametere.fylkesnummer,
            søkeparametere.kommunenummer)
        val virksomheter = sykefraversstatistikkRepository.hentSykefraværIKommuner(gyldigeKommunenummerISøk, søkeparametere = søkeparametere).toDto()
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