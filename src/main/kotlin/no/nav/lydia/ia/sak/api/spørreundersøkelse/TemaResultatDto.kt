package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable

@Serializable
data class TemaResultatDto(
    val temaId: Int,
    val tema: String,
    val beskrivelse: String,
    val spørsmålMedSvarDto: List<SpørsmålMedSvarDto>,
)

@Serializable
data class SvarDto(
    val svarId: String,
    val tekst: String,
    val antallSvar: Int,
)

@Serializable
data class SpørsmålMedSvarDto(
    val spørsmålId: String,
    val tekst: String,
    val flervalg: Boolean,
    val svarDtoListe: List<SvarDto>,
)