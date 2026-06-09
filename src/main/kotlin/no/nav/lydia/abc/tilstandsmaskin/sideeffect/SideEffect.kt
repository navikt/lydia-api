package no.nav.lydia.abc.tilstandsmaskin.sideeffect

import arrow.core.Either
import no.nav.lydia.abc.tilstandsmaskin.NyFlytService
import no.nav.lydia.ia.sak.api.Feil

sealed class SideEffect<T> {
    context(nyFlytService: NyFlytService)
    abstract fun apply(): Either<Feil, T>
}
