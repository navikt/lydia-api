package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse

import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

data class VurderVirksomhet(
    override val orgnr: String,
    val superbruker: NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker,
    val navEnhet: NavEnhet,
    val valgtÅrsak: ValgtÅrsak? = null,
) : Hendelse()
