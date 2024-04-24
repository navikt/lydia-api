package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørsmålOgSvaralternativerDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.toDto

@Serializable
data class TemaMedSpørsmålOgSvaralternativerDto(
    val temaId: Int,
    val temanavn: Temanavn,
    val beskrivelse: String,
    val introtekst: String,
    val spørsmålOgSvaralternativer: List<SpørsmålOgSvaralternativerDto>,
)

fun TemaMedSpørsmålOgSvaralternativer.toDto() =
    TemaMedSpørsmålOgSvaralternativerDto(
        temaId = this.tema.id,
        temanavn = this.tema.navn,
        beskrivelse = this.tema.beskrivelse,
        introtekst = this.tema.introtekst,
        spørsmålOgSvaralternativer = this.spørsmålOgSvaralternativer.toDto()
    )