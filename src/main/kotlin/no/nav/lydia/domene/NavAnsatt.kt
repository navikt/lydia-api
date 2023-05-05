package no.nav.lydia.domene

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.server.application.*
import no.nav.lydia.domene.NavAnsatt.Lesebruker.Companion.lesebruker
import no.nav.lydia.domene.NavAnsatt.Saksbehandler.Companion.saksbehandler
import no.nav.lydia.domene.NavAnsatt.Superbruker.Companion.superbruker
import no.nav.lydia.domene.NavAnsatt.UverifisertBruker.Companion.navAnsatt
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.tilgangskontroll.RådgiverError
import no.nav.lydia.tilgangskontroll.azureADGrupper
import no.nav.lydia.tilgangskontroll.innloggetNavIdent
import no.nav.lydia.tilgangskontroll.innloggetNavn

object ADGrupper {
    const val lesebrukerGruppe = "lesebruker"
    const val saksbehandlerGruppe = "saksbehandler"
    const val superbrukerGruppe = "suberbruker"
}

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
            fun UverifisertBruker.lesebruker() =
                validert(ansattesGrupper.contains(ADGrupper.lesebrukerGruppe)) {
                    Lesebruker(this)
                }
        }
    }

    class Saksbehandler private constructor(navAnsatt: UverifisertBruker) : NavAnsatt(navAnsatt) {
        companion object {
            fun UverifisertBruker.saksbehandler() =
                validert(ansattesGrupper.contains(ADGrupper.saksbehandlerGruppe)) {
                    Saksbehandler(this)
                }
        }
    }

    class Superbruker private constructor(navAnsatt: UverifisertBruker) : NavAnsatt(navAnsatt) {
        companion object {
            fun UverifisertBruker.superbruker() =
                validert(ansattesGrupper.contains(ADGrupper.superbrukerGruppe)) {
                    Superbruker(this)
                }
        }
    }

}

fun <T> ApplicationCall.somLesebruker(block: (NavAnsatt.Lesebruker) -> T) =
    this.navAnsatt()
        .flatMap { it.lesebruker() }
        .map { block(it) }

fun <T> ApplicationCall.somSaksbehandler(block: (NavAnsatt.Saksbehandler) -> T) =
    this.navAnsatt()
        .flatMap { it.saksbehandler() }
        .map { block(it) }

fun <T> ApplicationCall.somSuperbruker(block: (NavAnsatt.Superbruker) -> T) =
    this.navAnsatt()
        .flatMap { it.superbruker() }
        .map { block(it) }

private fun <T> validert(condition: Boolean, provider: () -> T) =
    when (condition) {
        false -> RådgiverError.IkkeAutorisert.left()
        true -> provider().right()
    }
