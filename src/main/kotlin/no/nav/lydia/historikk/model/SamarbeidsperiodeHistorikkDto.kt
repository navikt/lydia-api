package no.nav.lydia.historikk.model

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.samarbeid.IASamarbeidDto

@Serializable
data class SamarbeidsperiodeHistorikkDto(
    val saksnummer: String,
    val opprettet: LocalDateTime,
    val sistEndret: LocalDateTime,
    val historikkHendelser: List<HistorikkHendelse>,
    val samarbeid: List<IASamarbeidDto>,
)
