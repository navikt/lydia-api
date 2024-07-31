package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.hardkodetPlanId
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

class PlanService(
    val iaProsessService: IAProsessService,
    val planObserverers: List<Observer<Plan>>,
    val planRepository: PlanRepository,
) {
    fun opprettPlan(
        iaSak: IASak,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    ): Either<Feil, Plan> =
        iaProsessService.hentEllerOpprettIAProsess(iaSak).flatMap { prosess ->
            planRepository.opprettPlan(
                planId = hardkodetPlanId, // TODO bytt til -> UUID.randomUUID() når det skal persisteres
                prosessId = prosess.id,
                saksbehandler = saksbehandler,
            )
        }.onRight { plan ->
            planObserverers.forEach { it.receive(plan) }
        }
}