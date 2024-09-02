package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.domene.plan.Plan

class OppdaterSistEndretPlanObserver(
    val planRepository: PlanRepository
) : Observer<Plan> {
    override fun receive(plan: Plan) {
        planRepository.oppdaterSistEndret(plan = plan)
    }
}