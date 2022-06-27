package no.nav.lydia.appstatus

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.UnleashKlient
import no.nav.lydia.UnleashToggleKeys

const val FEATURE_TOGGLE_PATH = "unleash"
const val FEATURE_TOGGLE_TEST_PATH = "$FEATURE_TOGGLE_PATH/test"
const val FEATURE_TOGGLE_ENABLE_PATH = "$FEATURE_TOGGLE_TEST_PATH/enable"
const val FEATURE_TOGGLE_DISABLE_PATH = "$FEATURE_TOGGLE_TEST_PATH/disable"

fun Route.featureToggle() {
    get(FEATURE_TOGGLE_TEST_PATH) {
        if (UnleashKlient.isEnabled(UnleashToggleKeys.testToggle)){
            call.respond(status = HttpStatusCode.OK, message = "Enabled!")
        } else{
            call.respond(status = HttpStatusCode.NotImplemented, message = "Not implemented!")
        }
    }

    get("$FEATURE_TOGGLE_ENABLE_PATH/{toggle}") {
        if (!UnleashKlient.isEnabled(UnleashToggleKeys.testToggle)) return@get call.respond(status = HttpStatusCode.BadRequest, message = "Not found")
        val toggle = call.parameters["toggle"] ?: return@get call.respond(status = HttpStatusCode.BadRequest, message = "Invalid toggle name")
        UnleashKlient.skruPåToggle(toggle)
        return@get call.respond(status = HttpStatusCode.OK, message = "Enabled $toggle")
    }

    get("${FEATURE_TOGGLE_DISABLE_PATH}/{toggle}") {
        if (!UnleashKlient.isEnabled(UnleashToggleKeys.testToggle)) return@get call.respond(status = HttpStatusCode.BadRequest, message = "Not found")
        val toggle = call.parameters["toggle"] ?: return@get call.respond(status = HttpStatusCode.BadRequest, message = "Invalid toggle name")
        UnleashKlient.skruAvToggle(toggle)
        return@get call.respond(status = HttpStatusCode.OK, message = "Disabled $toggle")
    }
}
