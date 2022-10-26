package no.nav.lydia.tilgangskontroll

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import no.nav.lydia.FiaRoller
import no.nav.lydia.exceptions.UautorisertException
import no.nav.lydia.ia.sak.api.Feil

class Rådgiver(val navIdent: String, val navn: String, fiaRoller: FiaRoller, rådgiversGrupper: List<String>) {
    private val tilgang = Tilgang(fiaRoller, rådgiversGrupper)
    val rolle get() = grupperTilRolle()

    companion object {
        fun from(call: ApplicationCall, fiaRoller: FiaRoller): Either<Feil, Rådgiver> {
            val navIdent = call.innloggetNavIdent() ?: return Either.Left(RådgiverError.FantIkkeNavIdent)
            val grupper = call.azureADGrupper() ?: return Either.Left(RådgiverError.FantIngenADGrupper)
            val navn = call.innloggetNavn() ?: return Either.Left(RådgiverError.FantIkkeNavn)
            return Either.Right(Rådgiver(navIdent = navIdent, navn = navn, fiaRoller = fiaRoller, rådgiversGrupper = grupper))
        }

        suspend fun <T> somSuperbruker(call: ApplicationCall, fiaRoller: FiaRoller, block: suspend (Rådgiver) -> Either<Feil, T>) =
            somRådgiver(call, fiaRoller, block = { rådgiver ->
                if (rådgiver.erSuperbruker()) block(rådgiver) else RådgiverError.IkkeAutorisert.left()
            })

        suspend fun <T> somBrukerMedSaksbehandlertilgang(call: ApplicationCall, fiaRoller: FiaRoller, block: suspend (Rådgiver) -> Either<Feil, T>) =
            somRådgiver(call, fiaRoller, block = { rådgiver ->
                if (rådgiver.erSaksbehandler()) block(rådgiver) else RådgiverError.IkkeAutorisert.left()
            })

        suspend fun <T> somBrukerMedLesetilgang(call: ApplicationCall, fiaRoller: FiaRoller, block: suspend (Rådgiver) -> Either<Feil, T>) =
            somRådgiver(call, fiaRoller, block = { rådgiver ->
                if (rådgiver.erLesebruker()) block(rådgiver) else RådgiverError.IkkeAutorisert.left()
            })

        private suspend fun <T> somRådgiver(call: ApplicationCall, fiaRoller: FiaRoller, block: suspend (Rådgiver) -> Either<Feil, T>) =
            from(call = call, fiaRoller = fiaRoller).flatMap { block(it) }
    }

    private fun grupperTilRolle() : Rolle =
        if      (erSuperbruker()) Rolle.SUPERBRUKER
        else if (erSaksbehandler()) Rolle.SAKSBEHANDLER
        else if (erLesebruker()) Rolle.LESE
        else throw UautorisertException()

    fun erSuperbruker() = tilgang.harSuperbrukerTilgang()
    fun erSaksbehandler() = tilgang.harSaksbehandlerTilgang()
    fun erLesebruker() = tilgang.harLeseTilgang()

    private inner class Tilgang(private val fiaRoller: FiaRoller, private val rådgiversGrupper: List<String>){
        fun harSuperbrukerTilgang() = rådgiversGrupper.contains(fiaRoller.superbrukerGroupId)
        fun harSaksbehandlerTilgang() = rådgiversGrupper.contains(fiaRoller.saksbehandlerGroupId) || harSuperbrukerTilgang()
        fun harLeseTilgang() = rådgiversGrupper.contains(fiaRoller.lesetilgangGroupId) || harSaksbehandlerTilgang()
    }

    enum class Rolle {
        LESE,
        SAKSBEHANDLER,
        SUPERBRUKER
    }
}

object RådgiverError {
    val IkkeAutorisert = Feil("Ikke autorisert", HttpStatusCode.Forbidden)
    val FantIkkeNavIdent = Feil("Fant ikke NAV-ident på tokenet", HttpStatusCode.Forbidden)
    val FantIkkeNavn = Feil("Fant ikke navn på tokenet", HttpStatusCode.Forbidden)
    val FantIngenADGrupper = Feil("Fant ingen AD-grupper på tokenet", HttpStatusCode.Forbidden)
}


