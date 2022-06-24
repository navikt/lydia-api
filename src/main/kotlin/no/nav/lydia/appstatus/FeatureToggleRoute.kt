package no.nav.lydia.appstatus

import io.getunleash.Unleash
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

const val FEATURE_TOGGLE_PATH = "unleash"

fun Route.featureToggle(unleash: Unleash) {
    get(FEATURE_TOGGLE_PATH) {
        if (unleash.isEnabled("pia.tester-unleash")){
            call.respond(status = HttpStatusCode.OK, message = "Enabled!")
        } else{
            call.respond(status = HttpStatusCode.NotImplemented, message = "Not implemented!")
        }
    }
}
