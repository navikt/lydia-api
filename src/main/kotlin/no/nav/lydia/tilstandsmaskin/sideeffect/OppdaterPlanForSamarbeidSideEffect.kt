package no.nav.lydia.tilstandsmaskin.sideeffect

import arrow.core.Either
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.felles.Feil
import no.nav.lydia.samarbeidsplan.EndreTemaRequest
import no.nav.lydia.samarbeidsplan.Plan
import no.nav.lydia.samarbeidsplan.PlanDto
import no.nav.lydia.samarbeidsplan.tilDtoMedPubliseringStatus
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.Transaction
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsplanTransactional.Companion.oppdaterSamarbeidsplan
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
            Transaction(nyFlytService.dataSource).transactional {
                val oppdatertSamarbeidsplan: Plan = oppdaterSamarbeidsplan(
                    planDto = planDto,
                    samarbeidId = samarbeidId,
                    endringer = endringer,
                ) ?: error("Kunne ikke oppdatere samarbeidsplan med id '$planId' for samarbeid $samarbeidId i sak $saksnummer")

                val planMedPubliseringStatusDto: PlanDto =
                    oppdatertSamarbeidsplan.tilDtoMedPubliseringStatus()

                Pair(oppdatertSamarbeidsplan, planMedPubliseringStatusDto)
            }.also { planOgIASak: Pair<Plan, PlanDto> ->
                nyFlytService.planService.varslePlanObservers(planOgIASak.first, PlanHendelseType.OPPDATER)
            }.second
        }
}
