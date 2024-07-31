package no.nav.lydia.ia.sak.api.plan

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.plan.PlanTema

@Serializable
data class PlanTemaDto(
    val id: Int,
    val navn: String,
    val planlagt: Boolean,
    val temaer: List<PlanUndertemaDto>,
    val ressurser: List<PlanRessursDto>,
)

fun List<PlanTema>.tilDtoer() = map { it.tilDto() }

fun PlanTema.tilDto(): PlanTemaDto {
    return PlanTemaDto(
        id = id,
        navn = navn,
        planlagt = planlagt,
        temaer = undertemaer.tilDtoer(),
        ressurser = ressurser.tilDtoer()
    )
}