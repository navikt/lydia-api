package no.nav.lydia.tilgangskontroll.fia

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.server.application.ApplicationCall
import no.nav.lydia.ADGrupper
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.tilgangskontroll.TilgangskontrollFeil
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Saksbehandler
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker

sealed class NavAnsatt private constructor(
    val navIdent: String,
    val navn: String,
    val token: String,
    internal val ansattesGrupper: Set<String>,
) {
    val rolle
        get() = when (this) {
            is Lesebruker -> Rolle.LESE
            is Saksbehandler -> Rolle.SAKSBEHANDLER
            is Superbruker -> Rolle.SUPERBRUKER
        }

    class Lesebruker private constructor(navIdent: String, navn: String, token: String, ansattesGrupper: Set<String>) :
        NavAnsatt(navIdent, navn, token, ansattesGrupper) {
        companion object {
            fun ApplicationCall.lesebruker(adGrupper: ADGrupper): Either<Feil, Lesebruker> {
                val navIdent = this.innloggetNavIdent() ?: return TilgangskontrollFeil.FantIkkeNavIdent.left()
                val navn = this.innloggetNavn() ?: return TilgangskontrollFeil.FantIkkeNavn.left()
                val ansattesGrupper = this.azureADGrupper() ?: return TilgangskontrollFeil.FantIngenADGrupper.left()
                val token = this.accessToken() ?: return TilgangskontrollFeil.FantIkkeToken.left()

                return validert(
                    setOf(
                        adGrupper.lesebrukerGruppe,
                        adGrupper.saksbehandlerGruppe,
                        adGrupper.superbrukerGruppe
                    ).any { ansattesGrupper.contains(it) }) {
                    Lesebruker(
                        navIdent = navIdent,
                        navn = navn,
                        token = token,
                        ansattesGrupper = ansattesGrupper.toSet()
                    )
                }
            }
        }
    }

    sealed class NavAnsattMedSaksbehandlerRolle private constructor(
        navIdent: String,
        navn: String,
        token: String,
        ansattesGrupper: Set<String>
    ) : NavAnsatt(navIdent, navn, token, ansattesGrupper) {
        companion object {
            fun ApplicationCall.navAnsattMedSaksbehandlerRolle(adGrupper: ADGrupper): Either<Feil, NavAnsattMedSaksbehandlerRolle> {
                val navIdent = this.innloggetNavIdent() ?: return TilgangskontrollFeil.FantIkkeNavIdent.left()
                val navn = this.innloggetNavn() ?: return TilgangskontrollFeil.FantIkkeNavn.left()
                val ansattesGrupper = this.azureADGrupper() ?: return TilgangskontrollFeil.FantIngenADGrupper.left()
                val token = this.accessToken() ?: return TilgangskontrollFeil.FantIkkeToken.left()

                return if (ansattesGrupper.contains(adGrupper.superbrukerGruppe))
                    validert(true) {
                        Superbruker(
                            navIdent = navIdent,
                            navn = navn,
                            token = token,
                            ansattesGrupper = ansattesGrupper.toSet()
                        )
                    }
                else
                    validert(ansattesGrupper.contains(adGrupper.saksbehandlerGruppe)) {
                        Saksbehandler(
                            navIdent = navIdent,
                            navn = navn,
                            token = token,
                            ansattesGrupper = ansattesGrupper.toSet()
                        )
                    }
            }
        }

        class Saksbehandler internal constructor(
            navIdent: String,
            navn: String,
            token: String,
            ansattesGrupper: Set<String>
        ) : NavAnsattMedSaksbehandlerRolle(navIdent, navn, token, ansattesGrupper)

        class Superbruker internal constructor(
            navIdent: String,
            navn: String,
            token: String,
            ansattesGrupper: Set<String>
        ) : NavAnsattMedSaksbehandlerRolle(navIdent, navn, token, ansattesGrupper)
    }

}

private fun <T> validert(condition: Boolean, provider: () -> T) =
    when (condition) {
        false -> TilgangskontrollFeil.IkkeAutorisert.left()
        true -> provider().right()
    }
