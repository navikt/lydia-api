package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.appstatus.PlanHendelseType

class SamarbeidplanMetrikkObserver : Observer<ObservedPlan> {
    override fun receive(input: ObservedPlan) {
        if (input.hendelsesType == PlanHendelseType.OPPRETT) {
            Metrics.loggOpprettSamarbeidsplan(input.plan)
        }
    }
}
