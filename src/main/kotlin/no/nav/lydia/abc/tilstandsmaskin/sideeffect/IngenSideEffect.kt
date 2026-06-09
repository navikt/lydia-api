package no.nav.lydia.abc.tilstandsmaskin.sideeffect

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.abc.tilstandsmaskin.NyFlytService
import no.nav.lydia.ia.sak.api.Feil

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
