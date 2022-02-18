package no.nav.lydia.virksomhet.brreg

import io.ktor.application.*
import io.ktor.http.*
import io.ktor.response.*
import io.ktor.routing.*

val VIRKSOMHETSIMPORT_PATH = "internal/virksomhetsimport"

fun Route.virksomhetsImport(brregDownloader: BrregDownloader) {
    get(VIRKSOMHETSIMPORT_PATH) {
        brregDownloader.lastNed()
        call.respond(HttpStatusCode.OK)
    }
}