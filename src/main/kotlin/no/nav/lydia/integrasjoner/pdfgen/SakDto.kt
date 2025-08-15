package no.nav.lydia.integrasjoner.pdfgen

import kotlinx.serialization.Serializable
import no.nav.lydia.integrasjoner.azure.NavEnhet

// -- TODO: denne kan fjernes når vi fjerner samarbeidsstatus journalføring
@Serializable
data class SakDto(
    val saksnummer: String,
    val navenhet: String,
)
// --

@Serializable
data class DokumentPubliseringSakDto(
    val saksnummer: String,
    val navenhet: NavEnhet,
)
