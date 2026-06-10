package no.nav.lydia.kartlegging

import kotlinx.serialization.Serializable

@Serializable
data class TemaDto(
    val temaId: Int,
    val navn: String,
    val spørsmålOgSvaralternativer: List<SpørsmålDto>,
)

fun Tema.tilDto(): TemaDto =
    TemaDto(
        temaId = id,
        navn = navn,
        spørsmålOgSvaralternativer = undertemaer.flatMap { it.spørsmål.tilDto(undertemanavn = it.navn) },
    )
