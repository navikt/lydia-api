package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable

@Serializable
data class TemaResultatDto(
    val temaId: Int,
    val tema: String,
    val beskrivelse: String,
    val spørsmålMedSvar: List<SpørsmålResultatDto>,
)

@Serializable
data class SpørsmålResultatDto(
    val spørsmålId: String,
    val tekst: String,
    val flervalg: Boolean,
    val svarListe: List<SvarResultatDto>,
)

@Serializable
data class SvarResultatDto(
    val svarId: String,
    val tekst: String,
    val antallSvar: Int,
)