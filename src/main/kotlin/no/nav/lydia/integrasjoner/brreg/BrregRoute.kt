package no.nav.lydia.integrasjoner.brreg

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.coroutines.launch

val VIRKSOMHETSIMPORT_PATH = "internal/virksomhetsimport"

fun Route.virksomhetsImport(brregDownloader: BrregDownloader) {
    get(VIRKSOMHETSIMPORT_PATH) {
        if (BrregDownloader.KJØRER_IMPORT.get()) {
            call.application.log.warn("Kjører allerede import av bedrifter.")
            return@get call.respond(HttpStatusCode.Conflict)
        }
        launch {
            brregDownloader.lastNed()
        }
        call.respond(HttpStatusCode.OK)
    }
}