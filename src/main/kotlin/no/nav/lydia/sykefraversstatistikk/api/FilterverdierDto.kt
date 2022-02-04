package no.nav.lydia.sykefraversstatistikk.api

import kotlinx.serialization.Serializable
import no.nav.lydia.sykefraversstatistikk.api.geografi.Fylke
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune

@Serializable
data class FilterverdierDto(val fylker: List<FylkeOgKommuner>)

@Serializable
data class FylkeOgKommuner (val fylke: Fylke, val kommuner: List<Kommune>)
