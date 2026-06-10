package no.nav.lydia.tilstandsmaskin.hendelse

import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.util.UUID

data class StartKartleggingForSamarbeid(
    override val orgnr: String,
    val spørreundersøkelseId: UUID,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : Hendelse()
