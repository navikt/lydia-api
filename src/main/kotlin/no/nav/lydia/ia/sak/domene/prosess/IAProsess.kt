package no.nav.lydia.ia.sak.domene.prosess

import kotlinx.datetime.LocalDateTime

data class IAProsess(
    val id: Int,
    val saksnummer: String,
    val navn: String?,
    val status: IAProsessStatus?,
    val opprettet: LocalDateTime,
    val sistEndret: LocalDateTime?,
)

enum class IAProsessStatus {
    AKTIV,
    FULLFØRT,
    SLETTET,
}
