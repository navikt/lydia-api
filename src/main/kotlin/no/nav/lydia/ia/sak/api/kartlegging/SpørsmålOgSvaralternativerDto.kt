package no.nav.lydia.ia.sak.api.kartlegging

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.SpørsmålOgSvaralternativer

@Serializable
data class SpørsmålOgSvaralternativerDto(
    val id: String,
    val spørsmål: String,
    val svaralternativer: List<SvaralternativDto>,
    val flervalg: Boolean,
)

fun List<SpørsmålOgSvaralternativer>.toDto() = map { it.toDto() }

fun SpørsmålOgSvaralternativer.toDto() =
    SpørsmålOgSvaralternativerDto(
        id = spørsmålId.toString(),
        spørsmål = spørsmåltekst,
        svaralternativer = svaralternativer.toDto(),
        flervalg = false, // default til 'false', vi støtter ikke flervalg spørsmål enda
    )
