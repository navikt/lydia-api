package no.nav.fia.integrasjoner.ssb

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.call
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get

val NÆRINGSIMPORT_URL = "internal/naringsimport"

fun Route.næringsImport(næringsDownloader: NæringsDownloader) {
    get(NÆRINGSIMPORT_URL) {
        næringsDownloader.lastNedNæringer()
        call.respond(HttpStatusCode.OK)
    }
}