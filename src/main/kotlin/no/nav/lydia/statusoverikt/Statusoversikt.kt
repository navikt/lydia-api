package no.nav.lydia.statusoverikt

import no.nav.lydia.ia.sak.domene.IAProsessStatus

@kotlinx.serialization.Serializable
data class Statusoversikt(
    val status: IAProsessStatus?,
    val antall: Int,
)
