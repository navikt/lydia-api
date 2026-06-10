package no.nav.lydia.prioritering.sykefraværsstatistikk.api.geografi

import kotlinx.serialization.Serializable

@Serializable
data class Fylke(
    val navn: String,
    val nummer: String,
)
