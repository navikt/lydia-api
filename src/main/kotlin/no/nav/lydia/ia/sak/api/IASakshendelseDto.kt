package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable

@Serializable
class IASakshendelseDto(
    val orgnummer: String,
    val hendelsesType: String
)