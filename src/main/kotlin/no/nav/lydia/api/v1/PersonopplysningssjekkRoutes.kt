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
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.team.IATeamService
import no.nav.lydia.tilgangskontroll.eierEllerFølgerAvSak

const val PERSONOPPLYSNINGSSJEKK_PATH =
    "$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/personopplysningssjekk"

fun Route.personopplysningssjekk(
    adGrupper: ADGrupper,
    iaSakService: IASakService,
    iaTeamService: IATeamService,
    personopplysningssjekk: Personopplysningssjekk,
) {
    post(PERSONOPPLYSNINGSSJEKK_PATH) {
        val personopplysningssjekkDto = call.receive<PersonopplysningssjekkDto>()

        either {
            call.eierEllerFølgerAvSak(
                adGrupper = adGrupper,
                iaSakService = iaSakService,
                iaTeamService = iaTeamService,
            ).bind()
            personopplysningssjekk.sjekk(personopplysningssjekkDto.tekst).bind()
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}
