package no.nav.lydia.samarbeid

import kotlinx.datetime.LocalDateTime
import no.nav.lydia.integrasjoner.azure.NavEnhet
import java.util.UUID

data class IASamarbeid(
    val id: Int,
    val offentligId: UUID,
    val saksnummer: String,
    val navn: String,
    val status: Status?,
    val navEnhet: NavEnhet,
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
