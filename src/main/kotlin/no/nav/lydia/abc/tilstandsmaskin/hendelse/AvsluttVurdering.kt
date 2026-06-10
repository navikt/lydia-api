package no.nav.lydia.abc.tilstandsmaskin.hendelse

import no.nav.lydia.abc.samarbeidsperiode.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

data class AvsluttVurdering(
    override val orgnr: String,
    val årsak: ValgtÅrsak,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : Hendelse()
