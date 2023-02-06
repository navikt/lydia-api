package no.nav.lydia.ia.sak.api

import kotlinx.datetime.LocalDate
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.Modul
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.LeveranseStatus

@Serializable
data class IASakLeveranseDto (
    val id : Int,
    val saksnummer: String,
    val modul: Modul,
    val frist: LocalDate,
    val status: LeveranseStatus
)

@Serializable
data class IASakLeveranseOpprettelsesDto (
    val saksnummer: String,
    val modulId: Int,
    val frist: LocalDate
)

fun IASakLeveranse.tilDto() =
    IASakLeveranseDto(
        id = id,
        saksnummer = saksnummer,
        modul = modul,
        frist = frist.toKotlinLocalDate(),
        status = status
    )

fun List<IASakLeveranse>.tilDto() = this.map { it.tilDto() }
