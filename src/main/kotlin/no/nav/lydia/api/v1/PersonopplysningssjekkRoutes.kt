package no.nav.lydia.api.v1

import io.ktor.http.HttpStatusCode
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.post
import no.nav.lydia.ADGrupper
import no.nav.lydia.personopplysninger.PersonopplysningssjekkDto
import no.nav.lydia.personopplysninger.sjekkForPersonopplysninger
import no.nav.lydia.tilgangskontroll.somSaksbehandler

const val PERSONOPPLYSNINGSSJEKK_PATH = "$NY_FLYT_API_PATH/personopplysningssjekk"

fun Route.personopplysningssjekk(adGrupper: ADGrupper) {
    post(PERSONOPPLYSNINGSSJEKK_PATH) {
        val personopplysningssjekkDto = call.receive<PersonopplysningssjekkDto>()

        call.somSaksbehandler(adGrupper = adGrupper) { _ ->
            sjekkForPersonopplysninger(personopplysningssjekkDto.tekst)
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}
