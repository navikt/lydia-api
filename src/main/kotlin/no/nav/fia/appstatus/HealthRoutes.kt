package no.nav.fia.appstatus

import io.ktor.server.application.call
import io.ktor.server.response.respondText
import io.ktor.server.routing.Routing
import io.ktor.server.routing.get


fun Routing.healthChecks() {
    get("internal/isalive") {
        call.respondText { "OK" }
    }
    get("internal/isready") {
        //TODO sørg for at appens avhengigheter, f.eks database-tilkoblingen / kafka consumer funker før vi svarer ja på isReady
        call.respondText { "OK" }
    }
}