package no.nav.lydia.ia.sak.api.plan

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.plan.PlanRessurs

@Serializable
data class PlanRessursDto(
    val id: Int,
    val beskrivelse: String,
    val url: String?,
)

fun List<PlanRessurs>.tilDtoer(): List<PlanRessursDto> = map { it.tilDto() }

fun PlanRessurs.tilDto(): PlanRessursDto =
    PlanRessursDto(
        id = id,
        beskrivelse = beskrivelse,
        url = url,
    )
