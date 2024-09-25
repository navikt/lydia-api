package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.ia.sak.domene.plan.Plan

class SamarbeidplanMetrikkObserver : Observer<Plan> {
    override fun receive(input: Plan) {
        Metrics.loggOpprettSamarbeidsplan(input)
    }
}