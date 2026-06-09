package no.nav.lydia.abc.kartlegging

import kotlinx.serialization.Serializable

@Serializable
data class OppdaterBehovsvurderingDto(
    val orgnummer: String,
    val saksnummer: String,
    val prosessId: Int,
)
