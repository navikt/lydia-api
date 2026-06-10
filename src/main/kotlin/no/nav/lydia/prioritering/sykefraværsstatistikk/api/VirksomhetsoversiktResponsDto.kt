package no.nav.lydia.prioritering.sykefraværsstatistikk.api

@kotlinx.serialization.Serializable
data class VirksomhetsoversiktResponsDto(
    val data: List<VirksomhetsoversiktDto>,
)
