package no.nav.lydia.appstatus

import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*

fun Routing.healthChecks() {
    get("internal/isalive") {
        call.respondText { "OK" }
    }
    get("internal/isready") {
        //TODO sørg for at appens avhengigheter, f.eks database-tilkoblingen / kafka consumer funker før vi svarer ja på isReady
        call.respondText { "OK" }
    }
}