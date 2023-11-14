package no.nav.lydia.statusoversikt

import no.nav.lydia.ia.sak.domene.IAProsessStatus

@kotlinx.serialization.Serializable
data class Statusoversikt(
    val status: IAProsessStatus?,
    val antall: Int,
)
