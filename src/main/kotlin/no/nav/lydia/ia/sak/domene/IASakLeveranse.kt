package no.nav.lydia.ia.sak.domene

import kotlinx.serialization.Serializable
import java.time.LocalDate
import java.time.LocalDateTime

data class IASakLeveranse(
    val id: Int,
    val saksnummer: String,
    val modul: Modul,
    val frist: LocalDate,
    val status: IASakLeveranseStatus,
    val opprettetAv: String,
    val sistEndret: LocalDateTime,
    val sistEndretAv: String,
    val fullført: LocalDateTime?
)

enum class IASakLeveranseStatus {
    UNDER_ARBEID, LEVERT // AVBRUTT?
}

@Serializable
data class IATjeneste (
    val id: Int,
    val navn: String
): Comparable<IATjeneste> {
    override fun compareTo(other: IATjeneste) =
        compareValuesBy(this, other) { it.navn }
}

data class Modul (
    val id: Int,
    val iaTjeneste: IATjeneste,
    val navn: String
)
