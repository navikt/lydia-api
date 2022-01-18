package no.nav.lydia.sykefraversstatistikk.api

import kotlinx.serialization.Serializable

@Serializable
data class FilterverdierDto(val fylker: List<FylkeDto> = FilterverdierDto.fylker) {
    companion object {
        val fylker = listOf(
            FylkeDto(
                "Innlandet",
                listOf(
                    KommuneDto("Alvdal")
                )
            )
        )
    }
}

@Serializable
data class FylkeDto(val navn: String, val kommuner: List<KommuneDto>)

@Serializable
data class KommuneDto(val navn: String)