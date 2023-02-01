package no.nav.lydia.ia.sak.domene

import kotlinx.serialization.Serializable
import java.time.LocalDate
import java.time.LocalDateTime

data class IASakLeveranse(
    val id: Int,
    val saksnummer: String,
    val aktivitet: Aktivitet,
    val frist: LocalDate,
    val status: LeveranseStatus,
    val opprettetAv: String,
    val sistEndret: LocalDateTime,
    val sistEndretAv: String,
)

enum class LeveranseStatus {
    UNDER_ARBEID, LEVERT // AVBRUTT?
}

@Serializable
data class Område (
    val id: Int,
    val navn: String
)

@Serializable
data class Aktivitet (
    val id: Int,
    val område: Område,
    val navn: String
)
