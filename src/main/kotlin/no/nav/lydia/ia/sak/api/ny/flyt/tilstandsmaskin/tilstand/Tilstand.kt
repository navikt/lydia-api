package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand

import no.nav.lydia.ia.sak.api.ny.flyt.FiaKontekst
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.Konsekvens
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.Hendelse

sealed class Tilstand {
    fun navn(): String = this.javaClass.simpleName

    fun kanUtføreAutomatiskTransisjon(): Boolean = this is VirksomhetErVurdert || this is AlleSamarbeidIVirksomhetErAvsluttet

    abstract fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Konsekvens
}
