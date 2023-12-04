package no.nav.lydia.appstatus

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.micrometer.prometheus.PrometheusConfig
import io.micrometer.prometheus.PrometheusMeterRegistry
import io.prometheus.client.Counter
import no.nav.lydia.ia.sak.domene.IASakshendelseType

private const val NAMESPACE = "pia"

class Metrics {
    companion object{
        val appMicrometerRegistry = PrometheusMeterRegistry(PrometheusConfig.DEFAULT)

        val virksomheterPrioritert = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_virksomheter_vurdert")
            .help("Antall virksomheter som blir vurdert for ia-samarbeid")
            .register(appMicrometerRegistry.prometheusRegistry)

        private val virksomheterSattTilBistår = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_virksomheter_vi_bistår")
            .help("Antall virksomheter som blir bistått med ia-samarbeid")
            .register(appMicrometerRegistry.prometheusRegistry)

        private val virksomheterFulført = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_virksomheter_fulført")
            .help("Antall virksomheter som har fullført ia-samarbeid")
            .register(appMicrometerRegistry.prometheusRegistry)

        fun loggHendelse(hendelsesType: IASakshendelseType) {
            when (hendelsesType) {
                IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS -> virksomheterSattTilBistår.inc()
                IASakshendelseType.FULLFØR_BISTAND -> virksomheterFulført.inc()
                else -> {}
            }
        }
    }
}

fun Routing.metrics() {
    get("/metrics") {
        call.respond(Metrics.appMicrometerRegistry.scrape())
    }
}
