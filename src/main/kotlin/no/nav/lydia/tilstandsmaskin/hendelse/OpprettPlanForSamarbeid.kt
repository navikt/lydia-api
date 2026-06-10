package no.nav.lydia.tilstandsmaskin.hendelse

import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.samarbeidsplan.PlanMalDto
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

data class OpprettPlanForSamarbeid(
    override val orgnr: String,
    val samarbeidId: Int,
    val plan: PlanMalDto,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : Hendelse()
