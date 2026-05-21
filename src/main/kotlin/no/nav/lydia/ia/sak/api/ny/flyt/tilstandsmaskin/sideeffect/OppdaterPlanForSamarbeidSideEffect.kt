package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect

import arrow.core.Either
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.Transaction
import no.nav.lydia.ia.sak.api.ny.flyt.oppdaterSamarbeidsplan
import no.nav.lydia.ia.sak.api.plan.EndreTemaRequest
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.api.plan.tilDtoMedPubliseringStatus
import no.nav.lydia.ia.sak.domene.plan.Plan
import java.util.UUID

class OppdaterPlanForSamarbeidSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val planId: UUID,
    val endringer: List<EndreTemaRequest>,
) : SideEffect<PlanDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, PlanDto> =
        nyFlytService.validerOppdateringAvSamarbeidsplan(
            samarbeidId = samarbeidId,
            planId = planId,
            endringAvPlan = endringer,
        ).map { planDto ->
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(receiver = tx) {
                    val oppdatertSamarbeidsplan: Plan = oppdaterSamarbeidsplan(
                        planDto = planDto,
                        samarbeidId = samarbeidId,
                        endringer = endringer,
                    ) ?: error("Kunne ikke oppdatere samarbeidsplan med id '$planId' for samarbeid $samarbeidId i sak $saksnummer")

                    val planMedPubliseringStatusDto: PlanDto =
                        oppdatertSamarbeidsplan.tilDtoMedPubliseringStatus()

                    Pair(oppdatertSamarbeidsplan, planMedPubliseringStatusDto)
                }
            }.also { planOgIASak: Pair<Plan, PlanDto> ->
                nyFlytService.planService.varslePlanObservers(planOgIASak.first, PlanHendelseType.OPPDATER)
            }.second
        }
}
