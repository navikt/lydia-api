package no.nav.lydia.integrasjoner.kartlegging

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.TemaMedSpørsmålOgSvar

@Serializable
data class Svar(
    val svarId: String,
    val tekst: String,
    val antallSvar: Int
)

@Serializable
data class SpørsmålMedSvar(
    val spørsmålId: String,
    val tekst: String,
    val svarListe: List<Svar>
)

@Serializable
data class KartleggingMedSvar(
    val kartleggingId: String,
    val antallUnikeDeltakereMedMinstEttSvar: Int,
    val antallUnikeDeltakereSomHarSvartPåAlt: Int,
    val spørsmålMedSvarPerTema: List<TemaMedSpørsmålOgSvar>
)