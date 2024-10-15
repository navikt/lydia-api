package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.ia.eksport.SamarbeidsplanProdusent
import no.nav.lydia.ia.sak.db.PlanRepository

class SendPlanPåKafkaObserver(
    val planRepository: PlanRepository,
    val samarbeidsplanProdusent: SamarbeidsplanProdusent
) : Observer<ObservedPlan> {

    override fun receive(input: ObservedPlan) {
        planRepository.hentSamarbeidsplanKafkaMelding(input.plan.id)?.let { plan ->
            samarbeidsplanProdusent.sendPåKafka(plan)
        }
    }
}
