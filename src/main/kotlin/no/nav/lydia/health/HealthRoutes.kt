package no.nav.lydia.health

import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*

fun Routing.healthChecks() {
    get("/isAlive") {
        call.respondText { "OK" }
    }
    get("/isReady") {
        call.respondText { "OK" }
    }
}