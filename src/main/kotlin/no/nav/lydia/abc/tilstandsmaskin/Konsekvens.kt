package no.nav.lydia.abc.tilstandsmaskin

import arrow.core.Either
import no.nav.lydia.abc.tilstandsmaskin.tilstand.Tilstand
import no.nav.lydia.ia.sak.api.Feil

data class Konsekvens(
    val nyTilstand: no.nav.lydia.abc.tilstandsmaskin.tilstand.Tilstand,
    val endring: Either<Feil, Any?>,
)
