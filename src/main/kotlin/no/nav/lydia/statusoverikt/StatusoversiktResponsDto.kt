package no.nav.lydia.statusoverikt

@kotlinx.serialization.Serializable
data class StatusoversiktResponsDto(
    val data: List<Statusoversikt>,
)
