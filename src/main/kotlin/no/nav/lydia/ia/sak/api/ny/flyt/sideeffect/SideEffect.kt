package no.nav.lydia.ia.sak.api.ny.flyt.sideeffect

import arrow.core.Either
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.domene.IASak.Status.NY
import no.nav.lydia.ia.sak.domene.IASakshendelse

sealed class SideEffect<T> {
    context(nyFlytService: no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService)
    abstract fun apply(): Either<Feil, T>
}
