package no.nav.lydia.sykefraversstatistikk.api

@kotlinx.serialization.Serializable
class ListResponse<T>(
    val data: List<T>,
    val total: Int? = null
)