package no.nav.lydia.statusoversikt

import kotlinx.serialization.Serializable
import no.nav.lydia.abc.samarbeidsperiode.IASak

@Serializable
data class Statusoversikt(
    val status: IASak.Status?,
    val antall: Int,
)
