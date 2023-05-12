package no.nav.lydia.ia.sak.domene

import kotlinx.serialization.Serializable
import no.nav.lydia.tilgangskontroll.Rolle
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
    val sistEndretAvRolle: Rolle?,
    val fullført: LocalDateTime?
) {
    fun slettet(): IASakLeveranse = this.copy(
        status = IASakLeveranseStatus.SLETTET,
    )
}

enum class IASakLeveranseStatus {
    UNDER_ARBEID, LEVERT, SLETTET
}

@Serializable
data class IATjeneste (
    val id: Int,
    val navn: String,
    val deaktivert: Boolean,
)

@Serializable
data class Modul (
    val id: Int,
    val iaTjeneste: IATjeneste,
    val navn: String,
    val deaktivert: Boolean,
)
