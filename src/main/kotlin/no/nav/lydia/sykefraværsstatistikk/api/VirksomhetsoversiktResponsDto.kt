package no.nav.lydia.sykefraværsstatistikk.api

@kotlinx.serialization.Serializable
data class VirksomhetsoversiktResponsDto(
    val data: List<VirksomhetsoversiktDto>,
)
