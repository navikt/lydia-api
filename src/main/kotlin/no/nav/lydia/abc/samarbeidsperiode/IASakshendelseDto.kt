package no.nav.lydia.abc.samarbeidsperiode

import kotlinx.serialization.Serializable

@Serializable
open class IASakshendelseDto(
    val orgnummer: String,
    val saksnummer: String,
    val hendelsesType: IASakshendelseType,
    val endretAvHendelseId: String,
    val payload: String? = null,
)
