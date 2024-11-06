package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.ia.sak.db.PlanRepository

class OppdaterSistEndretPlanObserver(
    val planRepository: PlanRepository,
) : Observer<ObservedPlan> {
    override fun receive(input: ObservedPlan) {
        planRepository.oppdaterSistEndret(plan = input.plan)
    }
}
