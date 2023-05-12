package no.nav.lydia.tilgangskontroll

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.server.application.*
import no.nav.lydia.ADGrupper
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.tilgangskontroll.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Saksbehandler
import no.nav.lydia.tilgangskontroll.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker

sealed class NavAnsatt private constructor(
    val navIdent: String,
    val navn: String,
) {
    private constructor(uverifisertBruker: UverifisertBruker) : this(uverifisertBruker.navIdent, uverifisertBruker.navn)

    val rolle
        get() = when (this) {
            is Lesebruker -> Rolle.LESE
            is Saksbehandler -> Rolle.SAKSBEHANDLER
            is Superbruker -> Rolle.SUPERBRUKER
            is UverifisertBruker -> null
        }

    class UverifisertBruker (
        navIdent: String,
        navn: String,
        internal val ansattesGrupper: Set<String>
    ) : NavAnsatt(
        navIdent = navIdent,
        navn = navn,
    ) {
        companion object {
            fun ApplicationCall.navAnsatt(): Either<Feil, UverifisertBruker> {
                val navIdent = this.innloggetNavIdent() ?: return TilgangskontrollFeil.FantIkkeNavIdent.left()
                val navn = this.innloggetNavn() ?: return TilgangskontrollFeil.FantIkkeNavn.left()
                val ansattesGrupper = this.azureADGrupper() ?: return TilgangskontrollFeil.FantIngenADGrupper.left()

                return UverifisertBruker(
                    navIdent = navIdent,
                    navn = navn,
                    ansattesGrupper = ansattesGrupper.toSet()
                ).right()
            }
        }
    }

    class Lesebruker private constructor(navAnsatt: UverifisertBruker) : NavAnsatt(navAnsatt) {
        companion object {
            fun UverifisertBruker.lesebruker(adGrupper: ADGrupper) =
                validert(
                    setOf(
                        adGrupper.lesebrukerGruppe,
                        adGrupper.saksbehandlerGruppe,
                        adGrupper.superbrukerGruppe
                    ).any { ansattesGrupper.contains(it) }) {
                    Lesebruker(this)
                }
        }
    }

    sealed class NavAnsattMedSaksbehandlerRolle private constructor(navAnsatt: UverifisertBruker): NavAnsatt(navAnsatt) {
        companion object {
            fun UverifisertBruker.navAnsattMedSaksbehandlerRolle(adGrupper: ADGrupper) =
                if(ansattesGrupper.contains(adGrupper.superbrukerGruppe))
                    validert(true) {
                        Superbruker(this)
                    }
                else
                    validert(ansattesGrupper.contains(adGrupper.saksbehandlerGruppe)) {
                        Saksbehandler(this)
                    }
        }
        class Saksbehandler internal constructor(navAnsatt: UverifisertBruker) : NavAnsattMedSaksbehandlerRolle(navAnsatt)
        class Superbruker internal constructor(navAnsatt: UverifisertBruker) : NavAnsattMedSaksbehandlerRolle(navAnsatt)
    }

}

private fun <T> validert(condition: Boolean, provider: () -> T) =
    when (condition) {
        false -> TilgangskontrollFeil.IkkeAutorisert.left()
        true -> provider().right()
    }
