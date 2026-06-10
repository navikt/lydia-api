package no.nav.lydia.dokumentpublisering

import kotlinx.serialization.Serializable
import no.nav.lydia.integrasjoner.azure.NavEnhet

@Serializable
data class DokumentPubliseringSakDto(
    val saksnummer: String,
    val navenhet: NavEnhet,
)
