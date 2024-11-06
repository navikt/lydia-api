package no.nav.lydia.ia.sak.domene.prosess

data class IAProsess(
    val id: Int,
    val saksnummer: String,
    val navn: String?,
    val status: IAProsessStatus?,
)

enum class IAProsessStatus {
    AKTIV,
    SLETTET,
}
