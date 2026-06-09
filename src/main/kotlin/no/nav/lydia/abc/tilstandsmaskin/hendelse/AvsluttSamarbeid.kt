package no.nav.lydia.abc.tilstandsmaskin.hendelse

import no.nav.lydia.abc.samarbeid.IASamarbeid
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.time.LocalDate

data class AvsluttSamarbeid(
    override val orgnr: String,
    val samarbeidId: Int,
    val typeAvslutning: IASamarbeid.Status, // FULLFØRT eller AVBRUTT
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
    val dato: LocalDate? = null,
) : Hendelse()
