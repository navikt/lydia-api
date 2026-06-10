package no.nav.lydia.tilstandsmaskin.hendelse

sealed class Hendelse {
    abstract val orgnr: String

    fun navn(): String = this.javaClass.simpleName
}
