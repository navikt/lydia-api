package no.nav.lydia.abc.tilstandsmaskin.sideeffect

import arrow.core.Either
import no.nav.lydia.abc.felles.Feil
import no.nav.lydia.abc.tilstandsmaskin.NyFlytService

sealed class SideEffect<T> {
    context(nyFlytService: NyFlytService)
    abstract fun apply(): Either<Feil, T>
}
