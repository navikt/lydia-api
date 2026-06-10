package no.nav.lydia.tilstandsmaskin.sideeffect

import arrow.core.Either
import no.nav.lydia.felles.Feil
import no.nav.lydia.tilstandsmaskin.NyFlytService

sealed class SideEffect<T> {
    context(nyFlytService: NyFlytService)
    abstract fun apply(): Either<Feil, T>
}
