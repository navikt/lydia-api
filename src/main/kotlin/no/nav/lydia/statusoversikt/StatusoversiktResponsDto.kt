package no.nav.lydia.statusoversikt

@kotlinx.serialization.Serializable
data class StatusoversiktResponsDto(
    val data: List<Statusoversikt>,
)
