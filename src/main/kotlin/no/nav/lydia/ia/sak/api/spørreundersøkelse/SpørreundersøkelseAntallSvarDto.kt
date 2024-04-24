package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseAntallSvar

@Serializable
data class SpørreundersøkelseAntallSvarDto(
    val spørreundersøkelseId: String,
    val spørsmålId: String,
    val antallSvar: Int,
)

fun SpørreundersøkelseAntallSvar.toDto() =
    SpørreundersøkelseAntallSvarDto(
        spørreundersøkelseId = spørreundersøkelseId.toString(),
        spørsmålId = spørsmålId.toString(),
        antallSvar = antallSvar
    )