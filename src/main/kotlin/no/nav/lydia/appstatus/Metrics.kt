package no.nav.lydia.appstatus

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.micrometer.prometheusmetrics.PrometheusConfig
import io.micrometer.prometheusmetrics.PrometheusMeterRegistry
import io.prometheus.metrics.core.metrics.Counter
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.KartleggingStatus

private const val NAMESPACE = "pia"

class Metrics {
    companion object {
        val appMicrometerRegistry = PrometheusMeterRegistry(PrometheusConfig.DEFAULT)

        val behovsvurderingerOpprettet = Counter.builder()
            .name("${NAMESPACE}_ia_behovsvurdering_opprettet")
            .help("Antall behovsvurderinger opprettet")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        val behovsvurderingerStartet = Counter.builder()
            .name("${NAMESPACE}_ia_behovsvurdering_startet")
            .help("Antall behovsvurderinger startet")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        val behovsvurderingerFullført = Counter.builder()
            .name("${NAMESPACE}_ia_behovsvurdering_fullfort")
            .help("Antall behovsvurderinger fullfort")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        val behovsvurderingerSlettet = Counter.builder()
            .name("${NAMESPACE}_ia_behovsvurdering_slettet")
            .help("Antall behovsvurderinger slettet")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        val virksomheterPrioritert = Counter.builder()
            .name("${NAMESPACE}_ia_virksomheter_vurdert")
            .help("Antall virksomheter som blir vurdert for ia-samarbeid")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val virksomheterSattTilBistår = Counter.builder()
            .name("${NAMESPACE}_ia_virksomheter_vi_bistar")
            .help("Antall virksomheter som blir bistått med ia-samarbeid")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val virksomheterFulført = Counter.builder()
            .name("${NAMESPACE}_ia_virksomheter_fulfort")
            .help("Antall virksomheter som har fullført ia-samarbeid")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        fun loggHendelse(hendelsesType: IASakshendelseType) {
            when (hendelsesType) {
                IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS -> virksomheterSattTilBistår.inc()
                IASakshendelseType.FULLFØR_BISTAND -> virksomheterFulført.inc()
                else -> {}
            }
        }

        fun loggBehovsvurdering(status: KartleggingStatus) {
            when (status) {
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
