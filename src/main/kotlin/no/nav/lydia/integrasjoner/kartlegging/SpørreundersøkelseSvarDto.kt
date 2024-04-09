package no.nav.lydia.integrasjoner.kartlegging

import kotlinx.serialization.Serializable

@Serializable
data class SpørreundersøkelseSvarDto (
    val spørreundersøkelseId: String,
    val sesjonId: String,
    val spørsmålId: String,
    @Deprecated("Skal slettes")
    val svarId: String,
    val svarIder: List<String>
)