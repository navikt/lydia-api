package no.nav.lydia.tilstandsmaskin

import arrow.core.Either
import no.nav.lydia.felles.Feil

data class Konsekvens(
    val nyTilstand: no.nav.lydia.tilstandsmaskin.tilstand.Tilstand,
    val endring: Either<Feil, Any?>,
)
