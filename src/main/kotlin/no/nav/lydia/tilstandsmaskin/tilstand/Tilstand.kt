package no.nav.lydia.tilstandsmaskin.tilstand

import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.Konsekvens
import no.nav.lydia.tilstandsmaskin.hendelse.Hendelse

sealed class Tilstand {
    fun navn(): String = this.javaClass.simpleName

    abstract fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Konsekvens
}
