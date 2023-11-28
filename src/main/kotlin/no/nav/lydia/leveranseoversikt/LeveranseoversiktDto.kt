package no.nav.lydia.leveranseoversikt

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.api.IATjenesteDto
import no.nav.lydia.ia.sak.api.ModulDto

@Serializable
data class LeveranseoversiktDto(
    val orgnr: String,
    val virksomhetsnavn: String,
    val iaTjeneste: IATjenesteDto,
    val modul: ModulDto,
    val tentativFrist: LocalDate,
    val status: String,
)
