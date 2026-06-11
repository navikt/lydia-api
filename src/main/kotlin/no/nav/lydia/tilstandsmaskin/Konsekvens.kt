package no.nav.lydia.tilstandsmaskin

import no.nav.lydia.tilstandsmaskin.tilstand.Tilstand

data class Konsekvens(
    val nyTilstand: Tilstand,
    val verdi: Any? = null,
)
