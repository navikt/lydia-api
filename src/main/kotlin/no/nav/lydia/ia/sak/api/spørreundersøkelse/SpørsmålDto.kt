package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål

@Serializable
data class SpørsmålDto(
    val id: String,
    val undertemanavn: String,
    val spørsmål: String,
    val svaralternativer: List<SvaralternativDto>,
    val flervalg: Boolean,
)

fun List<Spørsmål>.tilDto(undertemanavn: String): List<SpørsmålDto> = map { it.tilDto(undertemanavn) }

fun Spørsmål.tilDto(undertemanavn: String): SpørsmålDto =
    SpørsmålDto(
        id = id.toString(),
        undertemanavn = undertemanavn,
        spørsmål = tekst,
        svaralternativer = svaralternativer.tilDto(),
        flervalg = flervalg,
    )
