package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.appstatus.PlanMetric

class SamarbeidplanMetrikkObserver : Observer<PlanMetric> {
    override fun receive(input: PlanMetric) {
        if (input.hendelsesType == PlanHendelseType.OPPRETT) {
            Metrics.loggOpprettSamarbeidsplan(input.plan)
        }
    }
}