package no.nav.lydia.abc.tilstandsmaskin.sideeffect

import arrow.core.Either
import no.nav.lydia.abc.samarbeidsplan.EndreUndertemaRequest
import no.nav.lydia.abc.samarbeidsplan.PlanDto
import no.nav.lydia.abc.samarbeidsplan.tilDtoMedPubliseringStatus
import no.nav.lydia.abc.tilstandsmaskin.NyFlytService
import no.nav.lydia.abc.tilstandsmaskin.Transaction
import no.nav.lydia.abc.tilstandsmaskin.oppdaterTemaISamarbeidsplan
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.plan.Plan
import java.util.UUID

class OppdaterTemaIPlanForSamarbeidSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val planId: UUID,
    val temaId: Int,
    val endringer: List<EndreUndertemaRequest>,
) : SideEffect<PlanDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, PlanDto> =
        nyFlytService.validerOppdateringAvTemaISamarbeidsplan(
            samarbeidId = samarbeidId,
            planId = planId,
            temaId = temaId,
            endringAvUndertema = endringer,
        ).map { planDto ->
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(receiver = tx) {
                    val oppdatertSamarbeidsplan: Plan = oppdaterTemaISamarbeidsplan(
                        planDto = planDto,
                        temaId = temaId,
                        samarbeidId = samarbeidId,
                        endringer = endringer,
                    ) ?: error("Kunne ikke oppdatere tema med id '$temaId' i samarbeidsplan med id '$planId' for samarbeid $samarbeidId i sak $saksnummer")

                    val planMedPubliseringStatusDto: PlanDto =
                        oppdatertSamarbeidsplan.tilDtoMedPubliseringStatus()

                    Pair(oppdatertSamarbeidsplan, planMedPubliseringStatusDto)
                }
            }.also { planOgIASak: Pair<Plan, PlanDto> ->
                nyFlytService.planService.varslePlanObservers(planOgIASak.first, PlanHendelseType.OPPDATER)
            }.second
        }
}
