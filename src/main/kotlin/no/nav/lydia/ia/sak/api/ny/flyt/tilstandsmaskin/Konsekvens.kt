package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin

import arrow.core.Either
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.Tilstand

data class Konsekvens(
    val nyTilstand: Tilstand,
    val endring: Either<Feil, Any?>,
)
