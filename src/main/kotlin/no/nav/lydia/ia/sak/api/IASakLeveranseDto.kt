package no.nav.lydia.ia.sak.api

import kotlinx.datetime.LocalDate
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.Aktivitet
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.LeveranseStatus

@Serializable
data class IASakLeveranseDto (
    val id : Int,
    val saksnummer: String,
    val aktivitet: Aktivitet,
    val frist: LocalDate?,
    val status: LeveranseStatus
)


fun IASakLeveranse.tilDto() =
    IASakLeveranseDto(
        id = id,
        saksnummer = saksnummer,
        aktivitet = aktivitet,
        frist = frist?.toKotlinLocalDate(),
        status = status
    )

fun List<IASakLeveranse>.tilDto() = this.map { it.tilDto() }
