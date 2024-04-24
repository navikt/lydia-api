package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaMedAntallSvar


@Serializable
data class TemaMedAntallSvarDto(
    val temabeskrivelse: String,
    val antallSpørsmål: Int,
    val antallUnikeDeltakereMedMinstEttSvar: Int,
    val antallUnikeDeltakereSomHarSvartPåAlt: Int,
    val status: String,
)

fun TemaMedAntallSvar.toDto() =
    TemaMedAntallSvarDto(
        temabeskrivelse = tema.beskrivelse,
        antallSpørsmål = antallSpørsmål,
        antallUnikeDeltakereMedMinstEttSvar = antallUnikeDeltakereMedMinstEttSvar,
        antallUnikeDeltakereSomHarSvartPåAlt = antallUnikeDeltakereSomHarSvartPåAlt,
        status = tema.status.name,
    )
