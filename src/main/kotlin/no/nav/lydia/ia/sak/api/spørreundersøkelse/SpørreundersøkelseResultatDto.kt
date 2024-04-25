package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable

@Serializable
data class SpørreundersøkelseResultatDto(
    val kartleggingId: String,
    val antallUnikeDeltakereMedMinstEttSvar: Int,
    val antallUnikeDeltakereSomHarSvartPåAlt: Int,
    val spørsmålMedSvarPerTema: List<TemaResultatDto>,
)
