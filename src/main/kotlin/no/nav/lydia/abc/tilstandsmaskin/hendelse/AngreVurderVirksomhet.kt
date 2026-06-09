
package no.nav.lydia.abc.tilstandsmaskin.hendelse

import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

data class AngreVurderVirksomhet(
    override val orgnr: String,
    val superbruker: NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker,
    val navEnhet: NavEnhet,
) : Hendelse()
