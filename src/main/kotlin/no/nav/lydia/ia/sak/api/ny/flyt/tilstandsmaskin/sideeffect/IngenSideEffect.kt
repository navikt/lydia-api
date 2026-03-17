package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService

object IngenSideEffect : SideEffect<Unit>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, Unit> =
        Either.Left(
            Feil(
                "Ikke håndtert enda",
                HttpStatusCode.Companion.BadRequest,
            ),
        )
}
