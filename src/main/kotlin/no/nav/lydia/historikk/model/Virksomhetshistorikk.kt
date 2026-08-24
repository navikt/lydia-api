package no.nav.lydia.historikk.model

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.samarbeidsperiode.IASak

@Serializable
data class Virksomhetshistorikk(
    val hendelser: List<Historikklinje>,
    val samarbeidsperioder: List<Samarbeidsperiode>,
) {
    fun tilDto(): VirksomhetshistorikkDto = this
}

@Serializable
data class Samarbeidsperiode(
    val saksnummer: String,
    val fraDato: LocalDateTime,
    val status: IASak.Status,
    val eier: String?,
)

// For å skille på det vi har i API og intern modell (like enn så lenge)
typealias VirksomhetshistorikkDto = Virksomhetshistorikk
