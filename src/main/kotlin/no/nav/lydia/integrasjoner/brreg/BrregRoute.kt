package no.nav.lydia.integrasjoner.brreg

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.call
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get

val VIRKSOMHETSIMPORT_PATH = "internal/virksomhetsimport"

fun Route.virksomhetsImport(brregDownloader: BrregDownloader) {
    get(VIRKSOMHETSIMPORT_PATH) {
        brregDownloader.lastNed()
        call.respond(HttpStatusCode.OK)
    }
}