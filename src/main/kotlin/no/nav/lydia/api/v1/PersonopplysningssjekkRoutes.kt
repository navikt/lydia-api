package no.nav.lydia.api.v1

import arrow.core.raise.either
import io.ktor.http.HttpStatusCode
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.post
import no.nav.lydia.ADGrupper
import no.nav.lydia.personopplysninger.Personopplysningssjekk
import no.nav.lydia.personopplysninger.PersonopplysningssjekkDto
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Companion.navAnsattMedSaksbehandlerRolle

const val PERSONOPPLYSNINGSSJEKK_PATH = "$NY_FLYT_API_PATH/personopplysningssjekk"

fun Route.personopplysningssjekk(
    adGrupper: ADGrupper,
    personopplysningssjekk: Personopplysningssjekk,
) {
    post(PERSONOPPLYSNINGSSJEKK_PATH) {
        val personopplysningssjekkDto = call.receive<PersonopplysningssjekkDto>()

        // somSaksbehandler tar en ikke-suspend blokk, så tilgangssjekk og KI-kall kjøres i either { }
        either {
            call.navAnsattMedSaksbehandlerRolle(adGrupper).bind()
            personopplysningssjekk.sjekk(personopplysningssjekkDto.tekst).bind()
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}
