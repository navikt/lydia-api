package no.nav.lydia.sykefraversstatistikk.api

import io.ktor.application.*
import io.ktor.http.*
import io.ktor.response.*
import io.ktor.routing.*
import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.virksomhet.ssb.NæringsRepository

val SYKEFRAVERSSTATISTIKK_PATH = "sykefraversstatistikk"
val FILTERVERDIER_PATH = "filterverdier"

fun Route.sykefraversstatistikk(
    geografiService: GeografiService,
    sykefraversstatistikkRepository: SykefraversstatistikkRepository,
    næringsRepository: NæringsRepository
) {
    get("$SYKEFRAVERSSTATISTIKK_PATH/") {
        val søkeparametere = Søkeparametere.from(call.request.queryParameters, geografiService)
        val virksomheter = sykefraversstatistikkRepository.hentSykefravær(søkeparametere = søkeparametere).toDto()
        call.respond(virksomheter)
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/{orgnummer}") {
        call.parameters["orgnummer"]?.let { orgnummer ->
            call.respond(sykefraversstatistikkRepository.hentSykefraværForVirksomhet(orgnummer).toDto())
        } ?: call.respond(HttpStatusCode.InternalServerError, "Fikk ikke tak i orgnummer")
    }

    get("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH") {
        call.respond(
            FilterverdierDto(
                fylker = geografiService.hentFylkerOgKommuner(),
                næringsgrupper = næringsRepository.hentNæringer()
            )
        )
    }
}