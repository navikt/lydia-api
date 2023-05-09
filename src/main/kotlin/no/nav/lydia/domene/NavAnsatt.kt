package no.nav.lydia.domene

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.server.application.*
import no.nav.lydia.ADGrupper
import no.nav.lydia.domene.NavAnsatt.Lesebruker.Companion.lesebruker
import no.nav.lydia.domene.NavAnsatt.Saksbehandler.Companion.saksbehandler
import no.nav.lydia.domene.NavAnsatt.Superbruker.Companion.superbruker
import no.nav.lydia.domene.NavAnsatt.UverifisertBruker.Companion.navAnsatt
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.tilgangskontroll.RådgiverError
import no.nav.lydia.tilgangskontroll.azureADGrupper
import no.nav.lydia.tilgangskontroll.innloggetNavIdent
import no.nav.lydia.tilgangskontroll.innloggetNavn

sealed class NavAnsatt private constructor(
    val navIdent: String,
    val navn: String,
) {
    private constructor(uverifisertBruker: UverifisertBruker) : this(uverifisertBruker.navIdent, uverifisertBruker.navn)

    class UverifisertBruker private constructor(
        navIdent: String,
        navn: String,
        internal val ansattesGrupper: Set<String>
    ) : NavAnsatt(
        navIdent = navIdent,
        navn = navn,
    ) {
        companion object {
            fun ApplicationCall.navAnsatt(): Either<Feil, UverifisertBruker> {
                val navIdent = this.innloggetNavIdent() ?: return RådgiverError.FantIkkeNavIdent.left()
                val navn = this.innloggetNavn() ?: return RådgiverError.FantIkkeNavn.left()
                val ansattesGrupper = this.azureADGrupper() ?: return RådgiverError.FantIngenADGrupper.left()

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
                validert(ansattesGrupper.contains(adGrupper.lesebrukerGruppe)) {
                    Lesebruker(this)
                }
        }
    }

    class Saksbehandler private constructor(navAnsatt: UverifisertBruker) : NavAnsatt(navAnsatt) {
        companion object {
            fun UverifisertBruker.saksbehandler(adGrupper: ADGrupper) =
                validert(ansattesGrupper.contains(adGrupper.saksbehandlerGruppe)) {
                    Saksbehandler(this)
                }
        }
    }

    class Superbruker private constructor(navAnsatt: UverifisertBruker) : NavAnsatt(navAnsatt) {
        companion object {
            fun UverifisertBruker.superbruker(adGrupper: ADGrupper) =
                validert(ansattesGrupper.contains(adGrupper.superbrukerGruppe)) {
                    Superbruker(this)
                }
        }
    }

}

fun <T> ApplicationCall.somLesebruker(adGrupper: ADGrupper, block: (NavAnsatt.Lesebruker) -> T) =
    this.navAnsatt()
        .flatMap { it.lesebruker(adGrupper = adGrupper) }
        .map { block(it) }

fun <T> ApplicationCall.somSaksbehandler(adGrupper: ADGrupper, block: (NavAnsatt.Saksbehandler) -> T) =
    this.navAnsatt()
        .flatMap { it.saksbehandler(adGrupper = adGrupper) }
        .map { block(it) }

fun <T> ApplicationCall.somSuperbruker(adGrupper: ADGrupper, block: (NavAnsatt.Superbruker) -> T) =
    this.navAnsatt()
        .flatMap { it.superbruker(adGrupper = adGrupper) }
        .map { block(it) }

private fun <T> validert(condition: Boolean, provider: () -> T) =
    when (condition) {
        false -> RådgiverError.IkkeAutorisert.left()
        true -> provider().right()
    }
