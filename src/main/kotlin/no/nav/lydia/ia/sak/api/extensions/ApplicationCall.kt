package no.nav.lydia.ia.sak.api.extensions

import io.ktor.server.application.ApplicationCall
import io.ktor.server.response.respond
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

val ApplicationCall.orgnummer
    get() = parameters["orgnummer"]
val ApplicationCall.saksnummer
    get() = parameters["saksnummer"]
val ApplicationCall.type
    get() = parameters["type"]?.let { Spørreundersøkelse.Type.valueOf(it) }
val ApplicationCall.spørreundersøkelseId
    get() = parameters["sporreundersokelseId"]
val ApplicationCall.iaSakLeveranseId
    get() = parameters["iaSakLeveranseId"]
val ApplicationCall.temaId
    get() = parameters["temaId"]?.toIntOrNull()
val ApplicationCall.prosessId
    get() = parameters["prosessId"]?.toIntOrNull()

suspend fun ApplicationCall.sendFeil(feil: Feil) = respond(feil.httpStatusCode, feil.feilmelding)
