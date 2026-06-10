package no.nav.lydia.abc.samarbeidsplan

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.ObservedPlan

class OppdaterSistEndretPlanObserver(
    val planRepository: PlanRepository,
) : Observer<ObservedPlan> {
    override fun receive(input: ObservedPlan) {
        planRepository.oppdaterSistEndret(plan = input.plan)
    }
}
