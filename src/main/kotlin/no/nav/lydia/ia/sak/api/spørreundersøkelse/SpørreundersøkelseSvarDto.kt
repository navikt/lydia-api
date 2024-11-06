package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable

@Serializable
data class SpørreundersøkelseSvarDto(
    val spørreundersøkelseId: String,
    val sesjonId: String,
    val spørsmålId: String,
    val svarIder: List<String>,
)
