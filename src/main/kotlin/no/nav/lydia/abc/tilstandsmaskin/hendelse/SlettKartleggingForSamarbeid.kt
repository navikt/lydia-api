package no.nav.lydia.abc.tilstandsmaskin.hendelse

import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.util.UUID

data class SlettKartleggingForSamarbeid(
    override val orgnr: String,
    val spørreundersøkelseId: UUID,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse()
