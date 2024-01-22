package no.nav.lydia.integrasjoner.kartlegging

import kotlinx.serialization.Serializable

@Serializable
data class KartleggingSvarDto (
    val spørreundersøkelseId: String,
    val sesjonId: String,
    val spørsmålId: String,
    val svarId: String
)