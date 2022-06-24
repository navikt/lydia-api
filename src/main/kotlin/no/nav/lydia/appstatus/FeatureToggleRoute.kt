package no.nav.lydia.appstatus

import io.getunleash.Unleash
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

const val FEATURE_TOGGLE_PATH = "unleash"
const val FEATURE_TOGGLE_TEST_PATH = "$FEATURE_TOGGLE_PATH/test"

object UnleashToggles {
    const val testToggle = "pia.tester-unleash"
    const val nyeStatuserToggle = "pia.nye-statuser"
}


fun Route.featureToggle(unleash: Unleash) {
    get(FEATURE_TOGGLE_TEST_PATH) {
        if (unleash.isEnabled(UnleashToggles.testToggle)){
            call.respond(status = HttpStatusCode.OK, message = "Enabled!")
        } else{
            call.respond(status = HttpStatusCode.NotImplemented, message = "Not implemented!")
        }
    }
}
