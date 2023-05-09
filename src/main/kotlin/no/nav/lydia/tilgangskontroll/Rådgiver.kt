package no.nav.lydia.tilgangskontroll

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import no.nav.lydia.ADGrupper
import no.nav.lydia.exceptions.UautorisertException
import no.nav.lydia.ia.sak.api.Feil

class Rådgiver(val navIdent: String, val navn: String, adGrupper: ADGrupper, rådgiversGrupper: List<String>) {
    private val tilgang = Tilgang(adGrupper, rådgiversGrupper)
    val rolle get() = grupperTilRolle()

    companion object {
        fun from(call: ApplicationCall, adGrupper: ADGrupper): Either<Feil, Rådgiver> {
            val navIdent = call.innloggetNavIdent() ?: return Either.Left(RådgiverError.FantIkkeNavIdent)
            val grupper = call.azureADGrupper() ?: return Either.Left(RådgiverError.FantIngenADGrupper)
            val navn = call.innloggetNavn() ?: return Either.Left(RådgiverError.FantIkkeNavn)
            return Either.Right(Rådgiver(navIdent = navIdent, navn = navn, adGrupper = adGrupper, rådgiversGrupper = grupper))
        }

        suspend fun <T> somSuperbruker(call: ApplicationCall, adGrupper: ADGrupper, block: suspend (Rådgiver) -> Either<Feil, T>) =
            somRådgiver(call, adGrupper, block = { rådgiver ->
                if (rådgiver.erSuperbruker()) block(rådgiver) else RådgiverError.IkkeAutorisert.left()
            })

        suspend fun <T> somBrukerMedSaksbehandlertilgang(call: ApplicationCall, adGrupper: ADGrupper, block: suspend (Rådgiver) -> Either<Feil, T>) =
            somRådgiver(call, adGrupper, block = { rådgiver ->
                if (rådgiver.erSaksbehandler()) block(rådgiver) else RådgiverError.IkkeAutorisert.left()
            })

        suspend fun <T> somBrukerMedLesetilgang(call: ApplicationCall, adGrupper: ADGrupper, block: suspend (Rådgiver) -> Either<Feil, T>) =
            somRådgiver(call, adGrupper, block = { rådgiver ->
                if (rådgiver.erLesebruker()) block(rådgiver) else RådgiverError.IkkeAutorisert.left()
            })

        private suspend fun <T> somRådgiver(call: ApplicationCall, adGrupper: ADGrupper, block: suspend (Rådgiver) -> Either<Feil, T>) =
            from(call = call, adGrupper = adGrupper).flatMap { block(it) }
    }

    private fun grupperTilRolle() : Rolle =
        if      (erSuperbruker()) Rolle.SUPERBRUKER
        else if (erSaksbehandler()) Rolle.SAKSBEHANDLER
        else if (erLesebruker()) Rolle.LESE
        else throw UautorisertException()

    fun erSuperbruker() = tilgang.harSuperbrukerTilgang()
    fun erSaksbehandler() = tilgang.harSaksbehandlerTilgang()
    fun erLesebruker() = tilgang.harLeseTilgang()

    private inner class Tilgang(private val adGrupper: ADGrupper, private val rådgiversGrupper: List<String>){
        fun harSuperbrukerTilgang() = rådgiversGrupper.contains(adGrupper.superbrukerGruppe)
        fun harSaksbehandlerTilgang() = rådgiversGrupper.contains(adGrupper.saksbehandlerGruppe) || harSuperbrukerTilgang()
        fun harLeseTilgang() = rådgiversGrupper.contains(adGrupper.lesebrukerGruppe) || harSaksbehandlerTilgang()
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


