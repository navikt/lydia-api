package no.nav.lydia.ia.sak

import no.nav.lydia.Observer
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene

class SpørreundersøkelseMetrikkObserver : Observer<SpørreundersøkelseDomene> {
    override fun receive(input: SpørreundersøkelseDomene) {
        when (input.type) {
            SpørreundersøkelseDomene.Type.Behovsvurdering -> Metrics.loggBehovsvurdering(status = input.status)
            SpørreundersøkelseDomene.Type.Evaluering -> Metrics.loggEvaluering(status = input.status)
        }
    }
}
