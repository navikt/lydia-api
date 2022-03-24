package no.nav.lydia.integrasjoner.ssb

import io.ktor.application.*
import io.ktor.http.*
import io.ktor.response.*
import io.ktor.routing.*

val NÆRINGSIMPORT_URL = "internal/naringsimport"

fun Route.næringsImport(næringsDownloader: NæringsDownloader) {
    get(NÆRINGSIMPORT_URL) {
        næringsDownloader.lastNedNæringer()
        call.respond(HttpStatusCode.OK)
    }
}