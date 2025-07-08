package no.nav.lydia.ia.sak.api.extensions

import io.ktor.server.application.ApplicationCall
import io.ktor.server.response.respond
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering.Companion.tilDokumentTilPubliseringType
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene
import java.util.UUID

val ApplicationCall.orgnummer
    get() = parameters["orgnummer"]
val ApplicationCall.saksnummer
    get() = parameters["saksnummer"]
val ApplicationCall.type
    get() = parameters["type"]?.let { SpørreundersøkelseDomene.Type.valueOf(it) }
val ApplicationCall.spørreundersøkelseId
    get() = parameters["sporreundersokelseId"]?.tilUUID("spørreundersøkelseId")
val ApplicationCall.iaSakLeveranseId
    get() = parameters["iaSakLeveranseId"]
val ApplicationCall.temaId
    get() = parameters["temaId"]?.toIntOrNull()
val ApplicationCall.prosessId
    get() = parameters["prosessId"]?.toIntOrNull()
val ApplicationCall.dokumentType
    get() = parameters["dokumentType"]?.tilDokumentTilPubliseringType()
val ApplicationCall.dokumentReferanseId
    get() = parameters["dokumentReferanseId"]?.tilUUID("dokumentReferanseId")

suspend fun ApplicationCall.sendFeil(feil: Feil) = respond(feil.httpStatusCode, feil.feilmelding)

fun String.tilUUID(hvaErJeg: String): UUID =
    try {
        UUID.fromString(this)
    } catch (e: Exception) {
        throw IllegalArgumentException(
            "Kunne ikke konvertere '$this' til UUID for $hvaErJeg",
            e,
        )
    }
