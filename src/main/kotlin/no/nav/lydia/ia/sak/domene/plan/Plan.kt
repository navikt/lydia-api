package no.nav.lydia.ia.sak.domene.plan

import java.util.UUID
import kotlinx.datetime.LocalDate

data class Plan(
    val id: UUID,
    val sistEndret: LocalDate,
    val publisert: Boolean,
    val sistPublisert: LocalDate?,
    val temaer: List<PlanTema>,
)
