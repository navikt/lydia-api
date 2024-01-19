package no.nav.lydia.ia.sak.api.kartlegging

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.Svaralternativ

@Serializable
data class SvaralternativDto(
    val id: String,
    val tekst: String
)

fun List<Svaralternativ>.toDto() = map { it.toDto() }
fun Svaralternativ.toDto() = SvaralternativDto(
    id = id.toString(),
    tekst = tekst
)