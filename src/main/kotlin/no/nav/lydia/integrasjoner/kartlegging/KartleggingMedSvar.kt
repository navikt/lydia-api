package no.nav.lydia.integrasjoner.kartlegging

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaMedSpørsmålOgSvar

@Serializable
data class KartleggingMedSvar(
    val kartleggingId: String,
    val antallUnikeDeltakereMedMinstEttSvar: Int,
    val antallUnikeDeltakereSomHarSvartPåAlt: Int,
    val spørsmålMedSvarPerTema: List<TemaMedSpørsmålOgSvar>
)

