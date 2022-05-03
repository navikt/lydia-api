package no.nav.fia.sykefraversstatistikk.api.geografi

import kotlinx.serialization.Serializable

@Serializable
data class Kommune(val navn: String, val nummer: String)