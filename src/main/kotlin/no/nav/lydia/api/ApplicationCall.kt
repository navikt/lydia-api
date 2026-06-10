package no.nav.lydia.api

import io.ktor.server.application.ApplicationCall
import io.ktor.server.response.respond
import no.nav.lydia.dokumentpublisering.DokumentPubliseringDto.Companion.tilDokumentTilPubliseringType
import no.nav.lydia.felles.Feil
import no.nav.lydia.felles.tilUUID
import no.nav.lydia.kartlegging.Spørreundersøkelse

val ApplicationCall.orgnummer
    get() = parameters["orgnummer"]
val ApplicationCall.saksnummer
    get() = parameters["saksnummer"]
val ApplicationCall.type
    get() = parameters["type"]?.let { Spørreundersøkelse.Type.valueOf(it) }
val ApplicationCall.spørreundersøkelseId
    get() = parameters["sporreundersokelseId"]?.tilUUID(hvaErJeg = "spørreundersøkelseId")
val ApplicationCall.kartleggingId
    get() = parameters["kartleggingId"]?.tilUUID(hvaErJeg = "kartleggingId")
val ApplicationCall.planId
    get() = parameters["planId"]?.tilUUID(hvaErJeg = "planId")
val ApplicationCall.temaId
    get() = parameters["temaId"]?.toIntOrNull()
val ApplicationCall.prosessId
    get() = parameters["prosessId"]?.toIntOrNull()
val ApplicationCall.samarbeidId
    get() = parameters["samarbeidId"]?.toIntOrNull()
val ApplicationCall.dokumentType
    get() = parameters["dokumentType"]?.tilDokumentTilPubliseringType()
val ApplicationCall.dokumentReferanseId
    get() = parameters["dokumentReferanseId"]?.tilUUID(hvaErJeg = "dokumentReferanseId")

suspend fun ApplicationCall.sendFeil(feil: Feil) = respond(feil.httpStatusCode, feil.feilmelding)
