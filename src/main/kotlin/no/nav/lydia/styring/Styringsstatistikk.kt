package no.nav.lydia.styring

import no.nav.lydia.ia.sak.domene.IAProsessStatus

@kotlinx.serialization.Serializable
data class Styringsstatistikk(
    val status: IAProsessStatus?,
    val antall: Int,
)
