package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse

sealed class Hendelse {
    abstract val orgnr: String

    fun navn(): String = this.javaClass.simpleName
}
