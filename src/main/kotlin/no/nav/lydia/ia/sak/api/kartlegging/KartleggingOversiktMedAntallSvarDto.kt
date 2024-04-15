package no.nav.lydia.ia.sak.api.kartlegging

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseOversiktMedAntallSvar
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaMedAntallSvar


@Serializable
data class TemaMedAntallSvarDto(
    val temabeskrivelse: String,
    val antallSpørsmål: Int,
    val antallUnikeDeltakereMedMinstEttSvar: Int,
    val antallUnikeDeltakereSomHarSvartPåAlt: Int,
    val status: String,
)

@Serializable
data class KartleggingOversiktMedAntallSvarDto(
    val kartleggingId: String,
    val antallUnikeDeltakereMedMinstEttSvar: Int,
    val antallUnikeDeltakereSomHarSvartPåAlt: Int,
    val spørsmålMedAntallSvarPerTema: List<TemaMedAntallSvarDto>,
)

fun TemaMedAntallSvar.toDto() =
    TemaMedAntallSvarDto(
        temabeskrivelse = tema.beskrivelse,
        antallSpørsmål = antallSpørsmål,
        antallUnikeDeltakereMedMinstEttSvar = antallUnikeDeltakereMedMinstEttSvar,
        antallUnikeDeltakereSomHarSvartPåAlt = antallUnikeDeltakereSomHarSvartPåAlt,
        status = tema.status.name,
    )

fun SpørreundersøkelseOversiktMedAntallSvar.toDto() =
    KartleggingOversiktMedAntallSvarDto(
        kartleggingId = kartleggingId.toString(),
        antallUnikeDeltakereMedMinstEttSvar = antallUnikeDeltakereMedMinstEttSvar,
        antallUnikeDeltakereSomHarSvartPåAlt = antallUnikeDeltakereSomHarSvartPåAlt,
        spørsmålMedAntallSvarPerTema = spørsmålMedAntallSvarPerTema.map { temaMedAntallSvar -> temaMedAntallSvar.toDto() }
    )
