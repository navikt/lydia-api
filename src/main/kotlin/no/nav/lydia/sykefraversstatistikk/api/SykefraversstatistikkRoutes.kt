package no.nav.lydia.sykefraversstatistikk.api

import io.ktor.application.call
import io.ktor.http.HttpStatusCode
import io.ktor.response.respond
import io.ktor.routing.Route
import io.ktor.routing.get
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
        val søkeparametere = Søkeparametere.from(call.request.queryParameters)
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
        call.respond(
            FilterverdierDto(
                fylker = geografiService.hentFylkerOgKommuner(),
                næringsgrupper = næringsRepository.hentNæringer()
            )
        )
    }
}