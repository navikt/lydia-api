package no.nav.lydia.sykefraversstatistikk.api

import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto.Companion.toDto
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet

interface ListResponse<T> {
    val data: List<T>
}

data class SykefraværsstatistikkListResponse(
    override val data: List<SykefraversstatistikkVirksomhet>,
) : ListResponse<SykefraversstatistikkVirksomhet>{
    companion object{
        fun SykefraværsstatistikkListResponse.toDto() = SykefraværsstatistikkListResponseDto(
            data = this.data.toDto(),
        )
    }
}

@kotlinx.serialization.Serializable
data class SykefraværsstatistikkListResponseDto(
    override val data: List<SykefraversstatistikkVirksomhetDto>,
) : ListResponse<SykefraversstatistikkVirksomhetDto>