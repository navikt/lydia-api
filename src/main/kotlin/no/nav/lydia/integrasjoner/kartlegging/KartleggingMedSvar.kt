package no.nav.lydia.integrasjoner.kartlegging

import java.util.*
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.Tema
import no.nav.lydia.ia.sak.domene.TemaMedSpørsmålOgSvar
import no.nav.lydia.ia.sak.domene.TemaStatus

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

data class TemaMedAntallSvar(
    val tema: Tema,
    val antallSpørsmål: Int,
    val antallUnikeDeltakereMedMinstEttSvar: Int,
    val antallUnikeDeltakereSomHarSvartPåAlt: Int,
    val status: TemaStatus
)

data class KartleggingOversiktMedAntallSvar(
    val kartleggingId: UUID,
    val antallUnikeDeltakereMedMinstEttSvar: Int,
    val antallUnikeDeltakereSomHarSvartPåAlt: Int,
    val spørsmålMedAntallSvarPerTema: List<TemaMedAntallSvar>
)
