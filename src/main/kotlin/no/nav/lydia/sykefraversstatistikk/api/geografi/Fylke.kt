package no.nav.lydia.sykefraversstatistikk.api.geografi

import kotlinx.serialization.Serializable

@Serializable
data class Fylke(val navn: String, val nummer: String)
