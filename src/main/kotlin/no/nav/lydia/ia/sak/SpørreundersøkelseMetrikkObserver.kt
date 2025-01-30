package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

class SpørreundersøkelseMetrikkObserver : Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) {
        when (input.type) {
            "behovsvurdering" -> Metrics.loggBehovsvurdering(input.status)
            "evaluering" -> Metrics.loggEvaluering(input.status)
            else -> {}
        }
    }
}
