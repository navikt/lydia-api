package no.nav.lydia.lederstatistikk

@kotlinx.serialization.Serializable
data class LederstatistikkResponsDto(
    val data: List<Lederstatistikk>,
)
