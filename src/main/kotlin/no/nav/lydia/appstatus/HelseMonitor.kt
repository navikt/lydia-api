package no.nav.lydia.appstatus

object HelseMonitor {
    private val helsesjekker: MutableList<Helsesjekk> = mutableListOf()

    fun leggTilHelsesjekk(vararg helsesjekk: Helsesjekk) {
        helsesjekker.addAll(helsesjekk)
    }

    fun erFrisk() = helsesjekker.all { it.helse() == Helse.UP }
}
