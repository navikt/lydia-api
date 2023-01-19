package no.nav.lydia.sykefraversstatistikk.api

interface ListResponse<T> {
    val data: List<T>
}

@kotlinx.serialization.Serializable
data class SykefraværsstatistikkListResponseDto(
    override val data: List<SykefraversstatistikkVirksomhetDto>,
) : ListResponse<SykefraversstatistikkVirksomhetDto>