package no.nav.lydia.ia.team

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.api.IASakDto

@Serializable
data class MineSakerDto(
    val iaSakDto: IASakDto,
    val orgnavn: String,
)