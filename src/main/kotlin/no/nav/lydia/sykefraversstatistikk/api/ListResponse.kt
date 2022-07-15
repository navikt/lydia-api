package no.nav.lydia.sykefraversstatistikk.api

import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet

interface ListResponse<T> {
    val data: List<T>
    val total: Int?
}

data class SykefraværsstatistikkListResponse(
    override val data: List<SykefraversstatistikkVirksomhet>,
    override val total: Int? = null
) : ListResponse<SykefraversstatistikkVirksomhet>{
    companion object{
        fun SykefraværsstatistikkListResponse.toDto() = SykefraværsstatistikkListResponseDto(
            data = this.data.toDto(),
            total = this.total
        )
    }
}

@kotlinx.serialization.Serializable
data class SykefraværsstatistikkListResponseDto(
    override val data: List<SykefraversstatistikkVirksomhetDto>,
    override val total: Int? = null
) : ListResponse<SykefraversstatistikkVirksomhetDto>