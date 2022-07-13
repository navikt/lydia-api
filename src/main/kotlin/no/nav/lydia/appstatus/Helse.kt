package no.nav.lydia.appstatus

enum class Helse {
    UP, DOWN
}

internal fun Boolean.tilHelse() = if (this) Helse.UP else Helse.DOWN
