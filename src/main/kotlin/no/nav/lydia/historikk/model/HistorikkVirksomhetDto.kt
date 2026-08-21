package no.nav.lydia.historikk.model

import kotlinx.serialization.Serializable

@Serializable
data class HistorikkVirksomhetDto(
    val historikkVirksomhet: HistorikkVirksomhet,
)
