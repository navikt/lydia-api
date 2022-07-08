package no.nav.lydia.appstatus

class HelseMonitor {
    private val helsesjekker: MutableList<Helsesjekk> = mutableListOf()

    fun helsesjekk(vararg helsesjekk: Helsesjekk) {
        helsesjekker.addAll(helsesjekk)
    }

    fun erFrisk() = helsesjekker.all { it.helse() == Helse.UP }
}