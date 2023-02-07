package no.nav.lydia.lederstatistikk

import no.nav.lydia.ia.sak.domene.IAProsessStatus

@kotlinx.serialization.Serializable
data class Lederstatistikk(
    val status: IAProsessStatus?,
    val antall: Int,
)
