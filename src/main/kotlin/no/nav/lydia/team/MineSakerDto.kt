package no.nav.lydia.team

import kotlinx.serialization.Serializable
import no.nav.lydia.samarbeidsperiode.IASakDto
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand

@Serializable
data class MineSakerDto(
    val iaSak: IASakDto,
    val orgnavn: String,
    val virksomhetTilstand: VirksomhetIATilstand,
)
