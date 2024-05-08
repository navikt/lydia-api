package no.nav.lydia.appstatus

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.micrometer.prometheus.PrometheusConfig
import io.micrometer.prometheus.PrometheusMeterRegistry
import io.prometheus.client.Counter
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.KartleggingStatus

private const val NAMESPACE = "pia"

class Metrics {
    companion object{
        val appMicrometerRegistry = PrometheusMeterRegistry(PrometheusConfig.DEFAULT)

        val behovsvurderingerOpprettet = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_behovsvurdering_opprettet")
            .help("Antall behovsvurderinger opprettet")
            .register(appMicrometerRegistry.prometheusRegistry)

        val behovsvurderingerStartet = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_behovsvurdering_startet")
            .help("Antall behovsvurderinger startet")
            .register(appMicrometerRegistry.prometheusRegistry)

        val behovsvurderingerFullført = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_behovsvurdering_fullfort")
            .help("Antall behovsvurderinger fullfort")
            .register(appMicrometerRegistry.prometheusRegistry)

        val behovsvurderingerSlettet = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_behovsvurdering_slettet")
            .help("Antall behovsvurderinger slettet")
            .register(appMicrometerRegistry.prometheusRegistry)

        val virksomheterPrioritert = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_virksomheter_vurdert")
            .help("Antall virksomheter som blir vurdert for ia-samarbeid")
            .register(appMicrometerRegistry.prometheusRegistry)

        private val virksomheterSattTilBistår = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_virksomheter_vi_bistar")
            .help("Antall virksomheter som blir bistått med ia-samarbeid")
            .register(appMicrometerRegistry.prometheusRegistry)

        private val virksomheterFulført = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_virksomheter_fulfort")
            .help("Antall virksomheter som har fullført ia-samarbeid")
            .register(appMicrometerRegistry.prometheusRegistry)

        fun loggHendelse(hendelsesType: IASakshendelseType) {
            when (hendelsesType) {
                IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS -> virksomheterSattTilBistår.inc()
                IASakshendelseType.FULLFØR_BISTAND -> virksomheterFulført.inc()
                else -> {}
            }
        }

        fun loggBehovsvurdering(status: KartleggingStatus) {
            when(status){
                KartleggingStatus.OPPRETTET -> behovsvurderingerOpprettet.inc()
                KartleggingStatus.PÅBEGYNT -> behovsvurderingerStartet.inc()
                KartleggingStatus.AVSLUTTET -> behovsvurderingerFullført.inc()
                KartleggingStatus.SLETTET -> behovsvurderingerSlettet.inc()
            }
        }
    }
}

fun Routing.metrics() {
    get("/metrics") {
        call.respond(Metrics.appMicrometerRegistry.scrape())
    }
}
