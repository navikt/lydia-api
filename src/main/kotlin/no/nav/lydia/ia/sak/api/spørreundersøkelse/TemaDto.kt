package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema

@Serializable
data class TemaDto(
    val temaId: Int,
    val navn: String,
    val spørsmålOgSvaralternativer: List<SpørsmålDto>,
)

fun Tema.toDto() =
    TemaDto(
        temaId = this.tema.id,
        navn = this.tema.navn,
        spørsmålOgSvaralternativer = this.spørsmål.tilDto(),
    )
