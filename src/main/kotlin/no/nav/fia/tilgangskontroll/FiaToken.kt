package no.nav.fia.tilgangskontroll

import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import no.nav.fia.Security

fun ApplicationCall.navIdent() = this.principal<JWTPrincipal>()?.payload?.claims?.get(Security.NAV_IDENT_CLAIM)?.asString()
fun ApplicationCall.azureADGrupper() = this.principal<JWTPrincipal>()?.payload?.claims?.get(Security.GROUPS_CLAIM)?.asList(String::class.java)