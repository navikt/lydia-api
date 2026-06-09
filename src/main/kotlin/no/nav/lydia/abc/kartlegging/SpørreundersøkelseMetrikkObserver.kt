package no.nav.lydia.abc.kartlegging

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.Metrics

class SpørreundersøkelseMetrikkObserver : Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) {
        when (input.type) {
            Spørreundersøkelse.Type.Behovsvurdering -> Metrics.loggBehovsvurdering(status = input.status)
            Spørreundersøkelse.Type.Evaluering -> Metrics.loggEvaluering(status = input.status)
        }
    }
}
