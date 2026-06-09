package no.nav.lydia.abc.tilstandsmaskin.tilstand

import no.nav.lydia.abc.tilstandsmaskin.FiaKontekst
import no.nav.lydia.abc.tilstandsmaskin.Konsekvens
import no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse

sealed class Tilstand {
    fun navn(): String = this.javaClass.simpleName

    abstract fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Konsekvens
}
