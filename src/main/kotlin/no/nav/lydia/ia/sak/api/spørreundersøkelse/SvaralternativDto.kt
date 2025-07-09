package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ

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
