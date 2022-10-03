package no.nav.lydia.ia.eksport

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.coroutines.launch

val IA_SAK_EKSPORT_PATH = "internal/iasakeksport"

fun Route.iaSakEksporterer(iaSakEksporterer: IASakEksporterer) {
    get(IA_SAK_EKSPORT_PATH) {
        if (IASakEksporterer.KJØRER_EKSPORT.get()) {
            call.application.log.warn("Kjører allerede import av bedrifter.")
            return@get call.respond(HttpStatusCode.Conflict)
        }
        launch {
            iaSakEksporterer.eksporter()
        }
        call.respond(HttpStatusCode.OK)
    }
}
