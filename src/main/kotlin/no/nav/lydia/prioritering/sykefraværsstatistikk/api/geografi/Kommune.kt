package no.nav.lydia.prioritering.sykefraværsstatistikk.api.geografi

import kotlinx.serialization.Serializable

@Serializable
data class Kommune(
    val navn: String,
    val navnNorsk: String? = null,
    val nummer: String,
)
