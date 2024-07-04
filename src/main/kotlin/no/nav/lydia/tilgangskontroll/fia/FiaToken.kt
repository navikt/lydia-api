package no.nav.lydia.tilgangskontroll.fia

import io.ktor.http.auth.AuthScheme
import io.ktor.http.auth.HttpAuthHeader
import io.ktor.server.application.ApplicationCall
import io.ktor.server.auth.jwt.JWTPrincipal
import io.ktor.server.auth.parseAuthorizationHeader
import io.ktor.server.auth.principal
import no.nav.lydia.Security

fun ApplicationCall.objectId() =
    this.principal<JWTPrincipal>()?.payload?.claims?.get(Security.OBJECT_ID_CLAIM)?.asString()

fun ApplicationCall.innloggetNavIdent() =
    this.principal<JWTPrincipal>()?.payload?.claims?.get(Security.NAV_IDENT_CLAIM)?.asString()

fun ApplicationCall.innloggetNavn() =
    this.principal<JWTPrincipal>()?.payload?.claims?.get(Security.NAME_CLAIM)?.asString()

fun ApplicationCall.azureADGrupper() =
    this.principal<JWTPrincipal>()?.payload?.claims?.get(Security.GROUPS_CLAIM)?.asList(String::class.java)

fun ApplicationCall.accessToken() = this.request.parseAuthorizationHeader()?.let {
    if (it.authScheme == AuthScheme.Bearer && it is HttpAuthHeader.Single)
        it.blob
    else
        null
}