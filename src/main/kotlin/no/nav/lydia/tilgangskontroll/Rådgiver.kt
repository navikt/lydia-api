package no.nav.lydia.tilgangskontroll

import arrow.core.Either
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import no.nav.lydia.Security

class Rådgiver(val navIdent: String, private val grupper: List<String>) {

    companion object {
        fun from(call: ApplicationCall): Either<RådgiverError, Rådgiver> {
            val navIdent = call.principal<JWTPrincipal>()?.payload?.claims?.get(Security.NAV_IDENT_CLAIM)?.asString()
                ?: return Either.Left(RådgiverError.FantIkkeNavIdent)
            val grupper =
                call.principal<JWTPrincipal>()?.payload?.claims?.get(Security.GROUPS_CLAIM)?.asList(String::class.java)
                    ?: return Either.Left(RådgiverError.FantIkkeNavIdent)
            return Either.Right(Rådgiver(navIdent = navIdent, grupper = grupper))
        }
    }

    fun harGruppe(gruppe: String) = grupper.contains(gruppe)
}

sealed class RådgiverError {
    object FantIkkeNavIdent : RådgiverError()
    object FantIngenADGrupper : RådgiverError()

    fun tilHTTPStatuskode() =
        when (this) {
            FantIkkeNavIdent -> HttpStatusCode.Forbidden
            FantIngenADGrupper -> HttpStatusCode.Forbidden
        }
}


