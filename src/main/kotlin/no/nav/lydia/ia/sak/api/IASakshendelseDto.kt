package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.SaksHendelsestype

@Serializable
class IASakshendelseDto(
    val orgnummer: String,
    val hendelsesType: SaksHendelsestype
)