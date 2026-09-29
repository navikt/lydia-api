package no.nav.lydia.samarbeidsplan

import kotlinx.serialization.Serializable

@Serializable
data class BrukerHarTilgang(
    val harTilgang: Boolean,
)
