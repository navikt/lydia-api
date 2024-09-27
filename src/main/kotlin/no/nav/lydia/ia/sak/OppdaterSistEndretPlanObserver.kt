package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.PlanMetric
import no.nav.lydia.ia.sak.db.PlanRepository

class OppdaterSistEndretPlanObserver(
    val planRepository: PlanRepository
) : Observer<PlanMetric> {
    override fun receive(input: PlanMetric) {
        planRepository.oppdaterSistEndret(plan = input.plan)
    }
}