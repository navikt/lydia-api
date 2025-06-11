package no.nav.lydia.statusoversikt

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASak

@Serializable
data class Statusoversikt(
    val status: IASak.Status?,
    val antall: Int,
)
