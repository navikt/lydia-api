package no.nav.lydia.abc.kartlegging

import kotlinx.datetime.LocalDateTime

data class Tema(
    val id: Int,
    val stengtForSvar: Boolean,
    val navn: String,
    val status: Status,
    val rekkefølge: Int,
    val sistEndret: LocalDateTime,
    val undertemaer: List<Undertema>,
) {
    enum class Status {
        AKTIV,
        INAKTIV,
    }
}
