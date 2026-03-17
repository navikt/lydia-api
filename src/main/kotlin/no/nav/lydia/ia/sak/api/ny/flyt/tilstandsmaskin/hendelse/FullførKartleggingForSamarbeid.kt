package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse

import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.util.UUID

data class FullførKartleggingForSamarbeid(
    override val orgnr: String,
    val spørreundersøkelseId: UUID,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : Hendelse()
