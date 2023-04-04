package no.nav.lydia.appstatus

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.micrometer.prometheus.PrometheusConfig
import io.micrometer.prometheus.PrometheusMeterRegistry
import io.prometheus.client.Counter

private const val NAMESPACE = "pia"

class Metrics {
    companion object{
        val appMicrometerRegistry = PrometheusMeterRegistry(PrometheusConfig.DEFAULT)

        val virksomheterPrioritert = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_virksomheter_vurdert")
            .help("Antall virksomheter som blir vurdert for ia-samarbeid")
            .register(appMicrometerRegistry.prometheusRegistry)

        val brregVirksomheterImportert = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_brreg_import_virksomheter")
            .help("Antall virksomheter som har blitt importert fra brreg")
            .register(appMicrometerRegistry.prometheusRegistry)

        val brregVirksomheterImportertIkkeRelevant = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_brreg_import_virksomheter_ikke_relevant")
            .help("Antall virksomheter som ikke er relevante under import fra brreg")
            .register(appMicrometerRegistry.prometheusRegistry)

        val brregVirksomheterImportertFeilet = Counter.build()
            .namespace(NAMESPACE)
            .name("ia_brreg_import_virksomheter_feilet")
            .help("Antall virksomheter som har feilet under import fra brreg")
            .register(appMicrometerRegistry.prometheusRegistry)
    }
}

fun Routing.metrics() {
    get("/metrics") {
        call.respond(Metrics.appMicrometerRegistry.scrape())
    }
}
