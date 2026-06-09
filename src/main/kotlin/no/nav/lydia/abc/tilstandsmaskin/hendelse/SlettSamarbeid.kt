package no.nav.lydia.abc.tilstandsmaskin.hendelse

import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.time.LocalDate

data class SlettSamarbeid(
    override val orgnr: String,
    val samarbeidId: Int,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
    val dato: LocalDate? = null,
) : no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse()
