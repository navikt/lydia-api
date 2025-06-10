package no.nav.lydia.ia.sak.domene.plan

import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import java.util.UUID

data class Plan(
    val id: UUID,
    val samarbeidId: Int,
    val sistEndret: LocalDateTime,
    val sistPublisert: LocalDate?,
    val status: IASamarbeid.Status,
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
