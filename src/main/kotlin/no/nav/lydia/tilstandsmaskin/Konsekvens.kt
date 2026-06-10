package no.nav.lydia.tilstandsmaskin

import arrow.core.Either
import no.nav.lydia.felles.Feil
import no.nav.lydia.tilstandsmaskin.tilstand.Tilstand

data class Konsekvens(
    val nyTilstand: Tilstand,
    val endring: Any? = null,
)
