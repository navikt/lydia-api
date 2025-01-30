package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

class SpørreundersøkelseMetrikkObserver : Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) {
        when (input.type) {
            "Behovsvurdering" -> Metrics.loggBehovsvurdering(input.status)
            "Evaluering" -> Metrics.loggEvaluering(input.status)
            else -> {}
        }
    }
}
