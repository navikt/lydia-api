package no.nav.lydia.tilgangskontroll

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.server.application.ApplicationCall
import no.nav.lydia.ADGrupper
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.Lesebruker
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.Lesebruker.Companion.lesebruker
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Companion.navAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import no.nav.lydia.tilgangskontroll.fia.objectId

fun <T> ApplicationCall.somLesebruker(
    adGrupper: ADGrupper,
    block: (Lesebruker) -> Either<Feil, T>,
) = this.lesebruker(adGrupper)
    .flatMap { block(it) }

fun <T> ApplicationCall.somSaksbehandler(
    adGrupper: ADGrupper,
    block: (NavAnsattMedSaksbehandlerRolle) -> Either<Feil, T>,
) = this.navAnsattMedSaksbehandlerRolle(adGrupper)
    .flatMap { block(it) }

fun ApplicationCall.superbruker(adGrupper: ADGrupper) =
    navAnsattMedSaksbehandlerRolle(adGrupper).flatMap {
        when (it) {
            is Superbruker -> it.right()
            else -> TilgangskontrollFeil.IkkeAutorisert.left()
        }
    }

fun <T> ApplicationCall.somSuperbruker(
    adGrupper: ADGrupper,
    block: (Superbruker) -> Either<Feil, T>,
) = superbruker(adGrupper).flatMap { block(it) }

fun <T> ApplicationCall.somHøyestTilgang(
    adGrupper: ADGrupper,
    block: (NavAnsatt) -> Either<Feil, T>,
): Either<Feil, T> {
    val harSaksbehandlerRolle = navAnsattMedSaksbehandlerRolle(adGrupper)
    val erLesebruker = lesebruker(adGrupper)

    return if (harSaksbehandlerRolle.isRight()) {
        harSaksbehandlerRolle.flatMap { block(it) }
    } else {
        erLesebruker.flatMap { block(it) }
    }
}

fun <T> ApplicationCall.somSaksbehandlerMedNavenhet(
    adGrupper: ADGrupper,
    azureService: AzureService,
    block: (NavAnsattMedSaksbehandlerRolle, NavEnhet) -> Either<Feil, T>,
): Either<Feil, T> =
    somSaksbehandler(adGrupper = adGrupper) { saksbehandler ->
        azureService.hentNavenhet(objectId()).flatMap { navEnhet ->
            block(saksbehandler, navEnhet)
        }
    }

fun <T> ApplicationCall.somSuperbrukerMedNavenhet(
    adGrupper: ADGrupper,
    azureService: AzureService,
    block: (Superbruker, NavEnhet) -> Either<Feil, T>,
): Either<Feil, T> =
    somSuperbruker(adGrupper = adGrupper) { superbruker ->
        azureService.hentNavenhet(objectId()).flatMap { navEnhet ->
            block(superbruker, navEnhet)
        }
    }
