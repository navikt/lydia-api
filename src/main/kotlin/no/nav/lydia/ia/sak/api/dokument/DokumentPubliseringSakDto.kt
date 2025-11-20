package no.nav.lydia.ia.sak.api.dokument

import kotlinx.serialization.Serializable
import no.nav.lydia.integrasjoner.azure.NavEnhet

@Serializable
data class DokumentPubliseringSakDto(
    val saksnummer: String,
    val navenhet: NavEnhet,
)
