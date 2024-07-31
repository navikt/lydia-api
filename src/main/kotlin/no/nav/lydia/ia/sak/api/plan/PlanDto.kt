package no.nav.lydia.ia.sak.api.plan

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.plan.Plan

@Serializable
data class PlanDto(
    val id: String,
    val sistEndret: LocalDate,
    val publisert: Boolean,
    val sistPublisert: LocalDate?,
    val temaer: List<PlanTemaDto>,
)

fun Plan.tilDto(): PlanDto {
    return PlanDto(
        id = id.toString(),
        sistEndret = sistEndret,
        publisert = publisert,
        sistPublisert = sistPublisert,
        temaer = temaer.tilDtoer(),
    )
}