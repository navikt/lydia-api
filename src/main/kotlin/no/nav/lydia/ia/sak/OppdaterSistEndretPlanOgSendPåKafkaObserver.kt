package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.ia.eksport.SamarbeidsplanProdusent
import no.nav.lydia.ia.sak.db.PlanRepository

class OppdaterSistEndretPlanOgSendPåKafkaObserver(
    val planRepository: PlanRepository,
    val samarbeidsplanProdusent: SamarbeidsplanProdusent
) : Observer<ObservedPlan> {

    override fun receive(input: ObservedPlan) {
        planRepository.oppdaterSistEndret(plan = input.plan)
        val oppdatertPlan = planRepository.hentPlan(input.plan.id)

        // send til Kafka
        if (input.hendelsesType == PlanHendelseType.OPPRETT && oppdatertPlan != null) {
            samarbeidsplanProdusent.sendPåKafka(oppdatertPlan)
        }
    }
}