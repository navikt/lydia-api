package no.nav.lydia.ia.sak.api.kartlegging

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.SpørsmålOgSvaralternativer

@Serializable
data class SpørsmålOgSvaralternativerDto(
    val id: String,
    val tema: String,
    val spørsmål: String,
    val antallSvar: Int,
    val svaralternativer: List<SvaralternativDto>,
)

fun List<SpørsmålOgSvaralternativer>.toDto() = map { it.toDto() }

fun SpørsmålOgSvaralternativer.toDto() =
    SpørsmålOgSvaralternativerDto(
        id = spørsmålId.toString(),
        tema = tema.name,
        spørsmål = spørsmåltekst,
        antallSvar = antallSvar,
        svaralternativer = svaralternativer.toDto(),
    )
