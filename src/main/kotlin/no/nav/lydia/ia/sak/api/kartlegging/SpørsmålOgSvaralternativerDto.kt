package no.nav.lydia.ia.sak.api.kartlegging

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.SpørsmålOgSvaralternativer

@Serializable
data class SpørsmålOgSvaralternativerDto(
    val id: String,
    val kategori: String,
    val spørsmål: String,
    val antallSvar: Int,
    val svaralternativer: List<SvaralternativDto>,
)

fun List<SpørsmålOgSvaralternativer>.toDto() = map { it.toDto() }

fun SpørsmålOgSvaralternativer.toDto() =
    SpørsmålOgSvaralternativerDto(
        id = spørsmålId.toString(),
        kategori = kategori.name,
        spørsmål = spørsmåltekst,
        antallSvar = antallSvar,
        svaralternativer = svaralternativer.toDto(),
    )
