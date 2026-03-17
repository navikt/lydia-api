package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect

import arrow.core.Either
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService

sealed class SideEffect<T> {
    context(nyFlytService: NyFlytService)
    abstract fun apply(): Either<Feil, T>
}
