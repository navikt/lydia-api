package no.nav.lydia.kartlegging

import kotlinx.serialization.Serializable

@Serializable
data class SvaralternativDto(
    val svarId: String,
    val svartekst: String,
)

fun List<Svaralternativ>.tilDto(): List<SvaralternativDto> = map { it.tilDto() }

fun Svaralternativ.tilDto(): SvaralternativDto =
    SvaralternativDto(
        svarId = id.toString(),
        svartekst = tekst,
    )
