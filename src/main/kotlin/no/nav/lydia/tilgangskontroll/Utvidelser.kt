package no.nav.lydia.tilgangskontroll

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.raise.either
import arrow.core.raise.ensure
import arrow.core.raise.ensureNotNull
import arrow.core.right
import io.ktor.server.application.ApplicationCall
import no.nav.lydia.ADGrupper
import no.nav.lydia.api.orgnummer
import no.nav.lydia.api.saksnummer
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.samarbeidsperiode.IASakError
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.team.IATeamService
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

fun ApplicationCall.eierEllerFølgerAvSak(
    adGrupper: ADGrupper,
    iaSakService: IASakService,
    iaTeamService: IATeamService,
): Either<Feil, NavAnsattMedSaksbehandlerRolle> =
    either {
        val saksbehandler = navAnsattMedSaksbehandlerRolle(adGrupper).bind()
        val orgnummer = ensureNotNull(orgnummer) { IASakError.`ugyldig orgnummer` }
        val saksnummer = ensureNotNull(saksnummer) { IASakError.`ugyldig saksnummer` }
        val iaSak = iaSakService.hentIASakDto(saksnummer = saksnummer).bind()
        ensure(iaSak.orgnr == orgnummer) { IASakError.`ugyldig orgnummer` }
        ensure(
            iaTeamService.erEierEllerFølgerAvSak(
                saksnummer = iaSak.saksnummer,
                eierAvSak = iaSak.eidAv,
                saksbehandler = saksbehandler,
            ),
        ) { IASakError.`er ikke følger eller eier av sak` }
        saksbehandler
    }

suspend fun <T> ApplicationCall.somSaksbehandlerMedNavenhet(
    adGrupper: ADGrupper,
    azureService: AzureService,
    block: (NavAnsattMedSaksbehandlerRolle, NavEnhet) -> Either<Feil, T>,
): Either<Feil, T> =
    either {
        val saksbehandler = navAnsattMedSaksbehandlerRolle(adGrupper).bind()
        val navEnhet = azureService.hentNavenhet(objectId()).bind()
        block(saksbehandler, navEnhet).bind()
    }

suspend fun <T> ApplicationCall.somSuperbrukerMedNavenhet(
    adGrupper: ADGrupper,
    azureService: AzureService,
    block: (Superbruker, NavEnhet) -> Either<Feil, T>,
): Either<Feil, T> =
    either {
        val superbruker = superbruker(adGrupper).bind()
        val navEnhet = azureService.hentNavenhet(objectId()).bind()
        block(superbruker, navEnhet).bind()
    }
