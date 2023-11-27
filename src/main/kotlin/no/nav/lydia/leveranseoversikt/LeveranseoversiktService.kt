package no.nav.lydia.leveranseoversikt

import arrow.core.Either
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.tilgangskontroll.NavAnsatt

class LeveranseoversiktService {
    fun hentMineLeveranser(saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle): Either<Feil, Leveranseoversikt> {

    }


}
