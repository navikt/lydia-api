package no.nav.lydia.sykefraversstatistikk.api

@kotlinx.serialization.Serializable
data class VirksomhetsoversiktResponsDto(
    val data: List<VirksomhetsoversiktDto>,
)
