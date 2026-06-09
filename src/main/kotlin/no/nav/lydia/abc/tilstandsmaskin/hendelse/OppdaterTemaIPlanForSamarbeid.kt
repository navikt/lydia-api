package no.nav.lydia.abc.tilstandsmaskin.hendelse

import no.nav.lydia.ia.sak.api.plan.EndreUndertemaRequest
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.util.UUID

data class OppdaterTemaIPlanForSamarbeid(
    override val orgnr: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val planId: UUID,
    val temaId: Int,
    val endringer: List<EndreUndertemaRequest>,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse()
