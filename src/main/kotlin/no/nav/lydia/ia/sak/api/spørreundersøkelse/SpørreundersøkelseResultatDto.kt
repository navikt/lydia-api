package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable

@Serializable
data class SpørreundersøkelseResultatDto(
    val id: String,
    val spørsmålMedSvarPerTema: List<TemaResultatDto>,
)

@Serializable
data class TemaResultatDto(
    val id: Int,
    val navn: String,
    val spørsmålMedSvar: List<SpørsmålResultatDto>,
)

@Serializable
data class SpørsmålResultatDto(
    val id: String,
    val tekst: String,
    val flervalg: Boolean,
    val antallDeltakereSomHarSvart: Int,
    val svarListe: List<SvarResultatDto>,
    val kategori: String,
)

@Serializable
data class SvarResultatDto(
    val id: String,
    val tekst: String,
    val antallSvar: Int,
)
