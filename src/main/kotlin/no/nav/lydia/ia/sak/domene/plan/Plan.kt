package no.nav.lydia.ia.sak.domene.plan

import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import java.util.UUID

data class Plan(
    val id: UUID,
    val sistEndret: LocalDateTime,
    val sistPublisert: LocalDate?,
    val temaer: List<PlanTema>,
) {
    fun startDato(): LocalDate? =
        temaer.flatMap { it.undertemaer }
            .filter { it.inkludert }
            .mapNotNull { it.startDato }
            .minOrNull()

    fun sluttDato(): LocalDate? =
        temaer.flatMap { it.undertemaer }
            .filter { it.inkludert }
            .mapNotNull { it.sluttDato }
            .maxOrNull()
}
