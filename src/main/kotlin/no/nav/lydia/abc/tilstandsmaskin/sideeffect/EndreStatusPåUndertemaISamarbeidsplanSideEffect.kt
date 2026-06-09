package no.nav.lydia.abc.tilstandsmaskin.sideeffect

import arrow.core.Either
import no.nav.lydia.abc.samarbeidsplan.PlanDto
import no.nav.lydia.abc.samarbeidsplan.tilDtoMedPubliseringStatus
import no.nav.lydia.abc.tilstandsmaskin.NyFlytService
import no.nav.lydia.abc.tilstandsmaskin.Transaction
import no.nav.lydia.abc.tilstandsmaskin.endreStatusPåUndertemaISamarbeidsplan
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import java.util.UUID

class EndreStatusPåUndertemaISamarbeidsplanSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val planId: UUID,
    val temaId: Int,
    val undertemaId: Int,
    val nyStatus: PlanUndertema.Status,
) : SideEffect<PlanDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, PlanDto> =
        nyFlytService.validerEndringAvStatusPåUndertema(
            samarbeidId = samarbeidId,
            planId = planId,
            temaId = temaId,
            undertemaId = undertemaId,
            nyStatus = nyStatus,
        ).map { _ ->
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(receiver = tx) {
                    val oppdatertPlan: Plan = endreStatusPåUndertemaISamarbeidsplan(
                        samarbeidId = samarbeidId,
                        temaId = temaId,
                        undertemaId = undertemaId,
                        nyStatus = nyStatus,
                    ) ?: error("Kunne ikke oppdatere status på undertema '$undertemaId' i plan '$planId' for samarbeid $samarbeidId i sak $saksnummer")

                    val planDto: PlanDto =
                        oppdatertPlan.tilDtoMedPubliseringStatus()

                    Pair(oppdatertPlan, planDto)
                }
            }.also { planOgDto: Pair<Plan, PlanDto> ->
                nyFlytService.planService.varslePlanObservers(planOgDto.first, PlanHendelseType.ENDRE_STATUS)
            }.second
        }
}
