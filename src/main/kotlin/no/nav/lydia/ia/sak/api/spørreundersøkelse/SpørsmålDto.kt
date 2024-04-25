package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål

@Serializable
data class SpørsmålDto(
    val id: String,
    val spørsmål: String,
    val svaralternativer: List<SvaralternativDto>,
    val flervalg: Boolean,
)

fun List<Spørsmål>.tilDto() = map { it.tilDto() }

fun Spørsmål.tilDto() =
    SpørsmålDto(
        id = spørsmålId.toString(),
        spørsmål = spørsmåltekst,
        svaralternativer = svaralternativer.tilDto(),
        flervalg = flervalg,
    )
