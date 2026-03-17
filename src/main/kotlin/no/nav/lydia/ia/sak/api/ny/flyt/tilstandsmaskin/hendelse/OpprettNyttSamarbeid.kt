package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse

import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

data class OpprettNyttSamarbeid(
    override val orgnr: String,
    val samarbeidsnavn: String,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : Hendelse()
