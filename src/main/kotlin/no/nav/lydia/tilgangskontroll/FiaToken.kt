package no.nav.lydia.tilgangskontroll

import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import no.nav.lydia.Security

fun ApplicationCall.objectId() = this.principal<JWTPrincipal>()?.payload?.claims?.get(Security.OBJECT_ID_CLAIM)?.asString()
fun ApplicationCall.innloggetNavIdent() = this.principal<JWTPrincipal>()?.payload?.claims?.get(Security.NAV_IDENT_CLAIM)?.asString()
fun ApplicationCall.innloggetNavn() = this.principal<JWTPrincipal>()?.payload?.claims?.get(Security.NAME_CLAIM)?.asString()
fun ApplicationCall.azureADGrupper() = this.principal<JWTPrincipal>()?.payload?.claims?.get(Security.GROUPS_CLAIM)?.asList(String::class.java)
