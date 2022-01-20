package no.nav.lydia.appstatus

import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*
import io.micrometer.prometheus.PrometheusConfig
import io.micrometer.prometheus.PrometheusMeterRegistry

class Metrics {
    companion object{
        val appMicrometerRegistry = PrometheusMeterRegistry(PrometheusConfig.DEFAULT)
    }
}

fun Routing.metrics() {
    get("/metrics") {
        call.respond(Metrics.appMicrometerRegistry.scrape())
    }
}