package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse

import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

data class VurderVirksomhet(
    override val orgnr: String,
    val superbruker: NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker,
    val navEnhet: NavEnhet,
) : Hendelse()
