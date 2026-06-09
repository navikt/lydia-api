package no.nav.lydia.abc.tilstandsmaskin.hendelse

import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.time.LocalDate

data class EndrePlanlagtDatoForNesteTilstand(
    override val orgnr: String,
    val nyPlanlagtDato: LocalDate,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse()
