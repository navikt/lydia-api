package no.nav.lydia.historikk

import kotlinx.serialization.Serializable

@Serializable
data class HistorikkVirksomhetDto(
    val historikkVirksomhet: HistorikkVirksomhet,
)
