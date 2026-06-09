package no.nav.lydia.abc.tilstandsmaskin.hendelse

import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

data class OpprettPlanForSamarbeid(
    override val orgnr: String,
    val samarbeidId: Int,
    val plan: PlanMalDto,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse()
