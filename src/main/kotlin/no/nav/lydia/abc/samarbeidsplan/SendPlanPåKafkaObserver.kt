package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.abc.samarbeidsplan.PlanRepository
import no.nav.lydia.abc.samarbeidsplan.SamarbeidsplanProdusent
import no.nav.lydia.appstatus.ObservedPlan

class SendPlanPåKafkaObserver(
    val planRepository: PlanRepository,
    val samarbeidsplanProdusent: SamarbeidsplanProdusent,
) : Observer<ObservedPlan> {
    override fun receive(input: ObservedPlan) {
        planRepository.hentSamarbeidsplanKafkaMelding(input.plan.id)?.let { plan ->
            samarbeidsplanProdusent.sendPåKafka(plan)
        }
    }
}
