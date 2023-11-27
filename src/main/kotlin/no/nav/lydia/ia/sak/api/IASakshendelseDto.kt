package no.nav.lydia.ia.sak.api


import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASakshendelseType

@Serializable
open class IASakshendelseDto(
    val orgnummer: String,
    val saksnummer: String,
    val hendelsesType: IASakshendelseType,
    val endretAvHendelseId: String,
    val payload: String? = null
)
