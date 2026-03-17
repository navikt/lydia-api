package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse

import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

data class OpprettKartleggingForSamarbeid(
    override val orgnr: String,
    val samarbeidId: Int,
    val type: `Spørreundersøkelse`.Type,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : Hendelse()
