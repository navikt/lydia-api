package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørsmålOgSvaralternativer

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
        flervalg = flervalg,
    )
