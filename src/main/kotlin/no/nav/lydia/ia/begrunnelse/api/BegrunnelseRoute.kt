package no.nav.lydia.ia.begrunnelse.api

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.ia.begrunnelse.db.BegrunnelseRepository

fun Route.begrunnelse(begrunnelseRepository: BegrunnelseRepository) {
    get {
        call.respond(begrunnelseRepository.hentBegrunnelser())
    }
}