package no.nav.lydia.virksomhet.domene

enum class Sektor(val kode: String, val beskrivelse: String) {
    STATLIG(kode = "1", beskrivelse = "Statlig forvaltning"),
    KOMMUNAL(kode = "2", beskrivelse = "Kommunal forvaltning"),
    PRIVAT(kode = "3", beskrivelse = "Privat og offentlig næringsvirksomhet"),
    FYLKESKOMMUNAL_FORVALTNING(kode = "9", beskrivelse = "Fylkeskommunal forvaltning")
}

fun String.tilSektor(): Sektor? {
    return when (this) {
        "1" -> Sektor.STATLIG
        "2" -> Sektor.KOMMUNAL
        "3" -> Sektor.PRIVAT
        "9" -> Sektor.FYLKESKOMMUNAL_FORVALTNING
        else -> null
    }
}
