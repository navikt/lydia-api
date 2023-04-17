package no.nav.lydia.sykefraversstatistikk.api.geografi

import kotlinx.serialization.Serializable

@Serializable
data class Kommune(
    val navn: String,
    val navnNorsk: String? = null,
    val nummer: String
)