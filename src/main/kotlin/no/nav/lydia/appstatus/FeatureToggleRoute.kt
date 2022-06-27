package no.nav.lydia.appstatus

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.UnleashKlient
import no.nav.lydia.UnleashToggleKeys

const val FEATURE_TOGGLE_PATH = "unleash"
const val FEATURE_TOGGLE_TEST_PATH = "$FEATURE_TOGGLE_PATH/test"

fun Route.featureToggle() {
    get(FEATURE_TOGGLE_TEST_PATH) {
        if (UnleashKlient.isEnabled(UnleashToggleKeys.testToggle)){
            call.respond(status = HttpStatusCode.OK, message = "Enabled!")
        } else{
            call.respond(status = HttpStatusCode.NotImplemented, message = "Not implemented!")
        }
    }
}
