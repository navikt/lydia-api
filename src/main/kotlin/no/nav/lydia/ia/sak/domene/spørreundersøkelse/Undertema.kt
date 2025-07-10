package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.datetime.LocalDateTime

data class Undertema(
    val id: Int,
    val navn: String,
    val status: Status,
    val rekkefølge: Int,
    val sistEndret: LocalDateTime,
    val spørsmål: List<Spørsmål>,
) {
    enum class Status {
        AKTIV,
        INAKTIV,
    }
}
