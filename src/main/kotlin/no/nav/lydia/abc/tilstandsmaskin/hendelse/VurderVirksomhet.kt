package no.nav.lydia.abc.tilstandsmaskin.hendelse

import no.nav.lydia.abc.samarbeidsperiode.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

data class VurderVirksomhet(
    override val orgnr: String,
    val superbruker: NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker,
    val navEnhet: NavEnhet,
    val valgtÅrsak: ValgtÅrsak? = null,
) : Hendelse()
