package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaMedSpørsmålOgSvaralternativer
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Temanavn

@Serializable
data class TemaDto(
    val temaId: Int,
    val temanavn: Temanavn,
    val beskrivelse: String,
    val introtekst: String,
    val spørsmålOgSvaralternativer: List<SpørsmålDto>,
)

fun TemaMedSpørsmålOgSvaralternativer.toDto() =
    TemaDto(
        temaId = this.tema.id,
        temanavn = this.tema.navn,
        beskrivelse = this.tema.beskrivelse,
        introtekst = this.tema.introtekst,
        spørsmålOgSvaralternativer = this.spørsmål.tilDto()
    )