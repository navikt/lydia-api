package no.nav.lydia.ia.sak.api.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.Temanavn
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema

@Serializable
data class TemaDto(
    val temaId: Int,
    val temanavn: Temanavn,
    val beskrivelse: String,
    val introtekst: String,
    val spørsmålOgSvaralternativer: List<SpørsmålDto>,
)

fun Tema.toDto() =
    TemaDto(
        temaId = this.tema.id,
        temanavn = this.tema.navn,
        beskrivelse = this.tema.beskrivelse,
        introtekst = this.tema.introtekst,
        spørsmålOgSvaralternativer = this.spørsmål.tilDto()
    )