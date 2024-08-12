package no.nav.lydia.ia.sak.domene.plan

import kotlinx.datetime.LocalDate
import java.util.UUID

data class Plan(
    val id: UUID,
    val sistEndret: LocalDate,
    val sistPublisert: LocalDate?,
    val temaer: List<PlanTema>,
) {
    val publisert get() = this.sistPublisert != null
}
