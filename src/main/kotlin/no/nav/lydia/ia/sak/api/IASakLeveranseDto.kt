package no.nav.lydia.ia.sak.api

import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.Modul
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IATjeneste

@Serializable
data class IASakLeveranseDto (
    val id : Int,
    val saksnummer: String,
    val modul: ModulDto,
    val frist: LocalDate,
    val status: IASakLeveranseStatus,
    val fullført: LocalDateTime?
)

@Serializable
data class ModulDto (
    val id: Int,
    val iaTjeneste: Int,
    val navn: String
)

@Serializable
data class IASakLeveranseOpprettelsesDto (
    val saksnummer: String,
    val modulId: Int,
    val frist: LocalDate
)

@Serializable
data class IASakLeveranseOppdateringsDto (
    val status: IASakLeveranseStatus
)

fun Modul.tilDto() = ModulDto(
    id = id,
    navn = navn,
    iaTjeneste = iaTjeneste.id
)

fun IASakLeveranse.tilDto() =
    IASakLeveranseDto(
        id = id,
        saksnummer = saksnummer,
        modul = modul.tilDto(),
        frist = frist.toKotlinLocalDate(),
        status = status,
        fullført = fullført?.toKotlinLocalDateTime()
    )

fun List<IASakLeveranse>.tilDto() = this.map { it.tilDto() }
fun List<IASakLeveranse>.tilIASakLeveranserPerTjenesteDto() =
    this.groupBy {
        it.modul.iaTjeneste
    }.map {
        IASakLeveranserPerTjenesteDto(
            iaTjeneste = it.key,
            leveranser = it.value.tilDto()
        )
    }

@Serializable
data class IASakLeveranserPerTjenesteDto(
    val iaTjeneste: IATjeneste,
    val leveranser: List<IASakLeveranseDto>
): Comparable<IASakLeveranserPerTjenesteDto> {
    override fun compareTo(other: IASakLeveranserPerTjenesteDto) =
        compareValuesBy(this, other) {
            it.iaTjeneste
        }
}
