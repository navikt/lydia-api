package no.nav.lydia.statusoversikt

import no.nav.lydia.ia.sak.domene.IASakStatus

@kotlinx.serialization.Serializable
data class Statusoversikt(
    val status: IASakStatus?,
    val antall: Int,
)
