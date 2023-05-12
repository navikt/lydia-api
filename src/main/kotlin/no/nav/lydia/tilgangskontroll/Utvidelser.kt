package no.nav.lydia.tilgangskontroll

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.server.application.*
import no.nav.lydia.ADGrupper
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.tilgangskontroll.NavAnsatt.Lesebruker
import no.nav.lydia.tilgangskontroll.NavAnsatt.Lesebruker.Companion.lesebruker
import no.nav.lydia.tilgangskontroll.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilgangskontroll.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Companion.navAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilgangskontroll.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import no.nav.lydia.tilgangskontroll.NavAnsatt.UverifisertBruker.Companion.navAnsatt

fun <T> ApplicationCall.somLesebruker(adGrupper: ADGrupper, block: (Lesebruker) -> Either<Feil, T>) =
    this.navAnsatt()
        .flatMap { it.lesebruker(adGrupper = adGrupper) }
        .flatMap { block(it) }

fun <T> ApplicationCall.somSaksbehandler(adGrupper: ADGrupper, block: (NavAnsattMedSaksbehandlerRolle) -> Either<Feil, T>) =
    this.navAnsatt()
        .flatMap { it.navAnsattMedSaksbehandlerRolle(adGrupper) }
        .flatMap { block(it) }

fun ApplicationCall.superbruker(adGrupper: ADGrupper) =
    navAnsatt().flatMap {
        it.navAnsattMedSaksbehandlerRolle(adGrupper)
    }.flatMap {
        when(it) {
            is Superbruker -> it.right()
            else -> TilgangskontrollFeil.IkkeAutorisert.left()
        }
    }
fun <T> ApplicationCall.somSuperbruker(adGrupper: ADGrupper, block: (Superbruker) -> Either<Feil, T>) =
    superbruker(adGrupper).flatMap { block(it) }



fun <T> ApplicationCall.somHøyestTilgang(adGrupper: ADGrupper, block: (NavAnsatt) -> Either<Feil, T>) =
    this.navAnsatt().flatMap { navAnsatt ->
        val harSaksbehandlerRolle = navAnsatt.navAnsattMedSaksbehandlerRolle(adGrupper)
        val erLesebruker = navAnsatt.lesebruker(adGrupper)

        if (harSaksbehandlerRolle.isRight())
            harSaksbehandlerRolle
        else
            erLesebruker
    }.flatMap {
        block(it)
    }
