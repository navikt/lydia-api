package no.nav.lydia.statusoversikt

import kotlinx.serialization.Serializable

@Serializable
data class StatusoversiktResponsDto(
    val data: List<Statusoversikt>,
)
