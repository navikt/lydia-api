package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable

@Serializable
data class SpørreundersøkelseResultatDto(
    val id: String,
    @Deprecated("Bruk id")
    val kartleggingId: String,
    val spørsmålMedSvarPerTema: List<TemaResultatDto>,
)

@Serializable
data class TemaResultatDto(
    val id: Int,
    @Deprecated("Bruk id")
    val temaId: Int,
    val navn: String,
    val spørsmålMedSvar: List<SpørsmålResultatDto>,
)

@Serializable
data class SpørsmålResultatDto(
    val id: String,
    @Deprecated("Bruk id")
    val spørsmålId: String,
    val tekst: String,
    val flervalg: Boolean,
    val antallDeltakereSomHarSvart: Int,
    val svarListe: List<SvarResultatDto>,
)

@Serializable
data class SvarResultatDto(
    val id: String,
    @Deprecated("Bruk id")
    val svarId: String,
    val tekst: String,
    val antallSvar: Int,
)
