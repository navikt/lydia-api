package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ

@Serializable
data class SvaralternativDto(
    val svarId: String,
    val svartekst: String,
)

fun List<Svaralternativ>.tilDto() = map { it.tilDto() }

fun Svaralternativ.tilDto() =
    SvaralternativDto(
        svarId = svarId.toString(),
        svartekst = svartekst,
    )
