package no.nav.lydia.ia.sak.domene.samarbeid

import kotlinx.datetime.LocalDateTime

data class IASamarbeid(
    val id: Int,
    val saksnummer: String,
    val navn: String,
    val status: Status?,
    val opprettet: LocalDateTime,
    val avbrutt: LocalDateTime?,
    val fullført: LocalDateTime?,
    val sistEndret: LocalDateTime?,
) {
    enum class Status {
        AKTIV,
        FULLFØRT,
        SLETTET,
        AVBRUTT,
    }
}
