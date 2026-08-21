package no.nav.lydia.historikk

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.samarbeidsperiode.IASak

@Serializable
data class HistorikkVirksomhet(
    val hendelser: List<Historikklinje>,
    val samarbeidsperioder: List<Samarbeidsperiode>,
)

@Serializable
data class Samarbeidsperiode(
    val saksnummer: String,
    val fraDato: LocalDateTime,
    val status: IASak.Status,
    val eier: String?,
)
