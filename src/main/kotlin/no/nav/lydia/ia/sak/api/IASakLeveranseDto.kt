package no.nav.lydia.ia.sak.api

import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IATjeneste
import no.nav.lydia.ia.sak.domene.Modul

@Serializable
data class IASakLeveranseDto(
    val id: Int,
    val saksnummer: String,
    val modul: ModulDto,
    val frist: LocalDate,
    val status: IASakLeveranseStatus,
    val fullført: LocalDateTime?,
)

@Serializable
data class IATjenesteDto(
    val id: Int,
    val navn: String,
    val deaktivert: Boolean,
) : Comparable<IATjenesteDto> {
    override fun compareTo(other: IATjenesteDto) = compareValuesBy(this, other) { it.navn }
}

fun IATjeneste.tilDto() =
    IATjenesteDto(
        id = id,
        navn = navn,
        deaktivert = deaktivert,
    )

@Serializable
data class ModulDto(
    val id: Int,
    val iaTjeneste: Int,
    val navn: String,
    val deaktivert: Boolean,
)

fun Modul.tilDto() =
    ModulDto(
        id = id,
        navn = navn,
        iaTjeneste = iaTjeneste.id,
        deaktivert = deaktivert,
    )

@Serializable
data class IASakLeveranseOpprettelsesDto(
    val saksnummer: String,
    val modulId: Int,
    val frist: LocalDate,
)

@Serializable
data class IASakLeveranseOppdateringsDto(
    val status: IASakLeveranseStatus,
)

fun IASakLeveranse.tilDto() =
    IASakLeveranseDto(
        id = id,
        saksnummer = saksnummer,
        modul = modul.tilDto(),
        frist = frist.toKotlinLocalDate(),
        status = status,
        fullført = fullført?.toKotlinLocalDateTime(),
    )

fun List<IASakLeveranse>.tilDto() = this.map { it.tilDto() }

fun List<IASakLeveranse>.tilIASakLeveranserPerTjenesteDto() =
    this.groupBy {
        it.modul.iaTjeneste
    }.map {
        IASakLeveranserPerTjenesteDto(
            iaTjeneste = it.key.tilDto(),
            leveranser = it.value.tilDto(),
        )
    }

@Serializable
data class IASakLeveranserPerTjenesteDto(
    val iaTjeneste: IATjenesteDto,
    val leveranser: List<IASakLeveranseDto>,
) : Comparable<IASakLeveranserPerTjenesteDto> {
    override fun compareTo(other: IASakLeveranserPerTjenesteDto) =
        compareValuesBy(this, other) {
            it.iaTjeneste
        }
}
