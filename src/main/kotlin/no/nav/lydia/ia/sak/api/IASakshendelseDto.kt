package no.nav.lydia.ia.sak.api


import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.SaksHendelsestype

@Serializable
open class IASakshendelseDto(
    val orgnummer: String,
    val saksnummer: String,
    val hendelsesType: SaksHendelsestype,
    val endretAvHendelseId: String,
    val payload: String? = null
)

@Serializable
class IASakshendelseOppsummeringDto(
    val id: String,
    val orgnummer: String,
    val saksnummer: String,
    val hendelsestype: SaksHendelsestype,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
)

