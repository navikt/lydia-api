package no.nav.lydia.appstatus

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.call
import io.ktor.server.response.respond
import io.ktor.server.response.respondText
import io.ktor.server.routing.Routing
import io.ktor.server.routing.get


fun Routing.healthChecks(helseMonitor: HelseMonitor) {
    get("internal/isalive") {
        if (helseMonitor.erFrisk()) {
            call.respondText { "OK" }
        } else {
            call.respond(HttpStatusCode.ServiceUnavailable, "Unhealthy")
        }
    }
    get("internal/isready") {
        if (helseMonitor.erFrisk()) {
            call.respondText { "OK" }
        } else {
            call.respond(HttpStatusCode.ServiceUnavailable, "Unhealthy")
        }
    }
}
