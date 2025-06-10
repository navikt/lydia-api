package no.nav.lydia.ia.sak.api.plan

import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid

@Serializable
data class PlanDto(
    val id: String,
    val sistEndret: LocalDateTime,
    val sistPublisert: LocalDate?,
    val status: IASamarbeid.Status,
    val temaer: List<PlanTemaDto>,
)

fun Plan.tilDto(): PlanDto =
    PlanDto(
        id = id.toString(),
        sistEndret = sistEndret,
        sistPublisert = sistPublisert,
        status = this.status,
        temaer = temaer.tilDtoer(),
    )
