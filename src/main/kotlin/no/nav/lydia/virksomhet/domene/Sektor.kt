package no.nav.lydia.virksomhet.domene

enum class Sektor(
    val kode: String,
    val beskrivelse: String,
) {
    STATLIG(kode = "1", beskrivelse = "Statlig forvaltning"),
    KOMMUNAL(kode = "2", beskrivelse = "Kommunal forvaltning"),
    PRIVAT(kode = "3", beskrivelse = "Privat og offentlig næringsvirksomhet"),
}

fun String.tilSektor(): Sektor? =
    when (this) {
        Sektor.STATLIG.kode -> Sektor.STATLIG
        Sektor.STATLIG.name -> Sektor.STATLIG
        Sektor.KOMMUNAL.kode -> Sektor.KOMMUNAL
        Sektor.KOMMUNAL.name -> Sektor.KOMMUNAL
        Sektor.PRIVAT.kode -> Sektor.PRIVAT
        Sektor.PRIVAT.name -> Sektor.PRIVAT
        else -> null
    }

fun String.erGyldigSektor(): Boolean = this.tilSektor() != null
