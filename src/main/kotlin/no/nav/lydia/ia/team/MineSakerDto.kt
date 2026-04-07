package no.nav.lydia.ia.team

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand

@Serializable
data class MineSakerDto(
    val iaSak: IASakDto,
    val orgnavn: String,
    val virksomhetTilstand: VirksomhetIATilstand,
)
