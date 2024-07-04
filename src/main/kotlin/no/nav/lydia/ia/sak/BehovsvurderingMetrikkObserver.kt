package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

class BehovsvurderingMetrikkObserver : Observer<Spørreundersøkelse> {
    override fun receive(input: Spørreundersøkelse) {
        Metrics.loggBehovsvurdering(input.status)
    }
}