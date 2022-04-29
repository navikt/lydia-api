package no.nav.lydia.tilgangskontroll

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import io.ktor.http.*
import io.ktor.server.application.*
import no.nav.lydia.FiaRoller
import no.nav.lydia.ia.sak.api.Feil

class Rådgiver(val navIdent: String, fiaRoller: FiaRoller, rådgiversGrupper: List<String>) {
    private val tilgang = Tilgang(fiaRoller, rådgiversGrupper)

    companion object {
        fun from(call: ApplicationCall, fiaRoller: FiaRoller): Either<Feil, Rådgiver> {
            val navIdent = call.navIdent() ?: return Either.Left(RådgiverError.FantIkkeNavIdent)
            val grupper = call.azureADGrupper() ?: return Either.Left(RådgiverError.FantIngenADGrupper)
            return Either.Right(Rådgiver(navIdent = navIdent, fiaRoller = fiaRoller, rådgiversGrupper = grupper))
        }


        fun <T> somSuperbruker(call: ApplicationCall, fiaRoller: FiaRoller, block: (Rådgiver) -> Either<Feil, T>) =
            somRådgiver(call, fiaRoller, block = { rådgiver ->
                if (rådgiver.erSuperbruker()) block(rådgiver) else RådgiverError.IkkeAutorisert.left()
            })

        fun <T> somBrukerMedSaksbehandlertilgang(call: ApplicationCall, fiaRoller: FiaRoller, block: (Rådgiver) -> Either<Feil, T>) =
            somRådgiver(call, fiaRoller, block = { rådgiver ->
                if (rådgiver.erSaksbehandler()) block(rådgiver) else RådgiverError.IkkeAutorisert.left()
            })

        fun <T> somBrukerMedLesetilgang(call: ApplicationCall, fiaRoller: FiaRoller, block: (Rådgiver) -> Either<Feil, T>) =
            somRådgiver(call, fiaRoller, block = { rådgiver ->
                if (rådgiver.erLesebruker()) block(rådgiver) else RådgiverError.IkkeAutorisert.left()
            })

        private fun <T> somRådgiver(call: ApplicationCall, fiaRoller: FiaRoller, block: (Rådgiver) -> Either<Feil, T>) =
            from(call = call, fiaRoller = fiaRoller).flatMap(block)
    }

    fun erSuperbruker() = tilgang.harSuperbrukerTilgang()
    fun erSaksbehandler() = tilgang.harSaksbehandlerTilgang()
    fun erLesebruker() = tilgang.harLeseTilgang()

    private inner class Tilgang(private val fiaRoller: FiaRoller, private val rådgiversGrupper: List<String>){
        fun harSuperbrukerTilgang() = rådgiversGrupper.contains(fiaRoller.superbrukerGroupId)
        fun harSaksbehandlerTilgang() = rådgiversGrupper.contains(fiaRoller.saksbehandlerGroupId) || harSuperbrukerTilgang()
        fun harLeseTilgang() = rådgiversGrupper.contains(fiaRoller.lesetilgangGroupId) || harSaksbehandlerTilgang()
    }
}

object RådgiverError {
    val IkkeAutorisert = Feil("Ikke autorisert", HttpStatusCode.Forbidden)
    val FantIkkeNavIdent = Feil("Fant ikke NAV-ident på tokenet", HttpStatusCode.Forbidden)
    val FantIngenADGrupper = Feil("Fant ingen AD-grupper på tokenet", HttpStatusCode.Forbidden)
}


