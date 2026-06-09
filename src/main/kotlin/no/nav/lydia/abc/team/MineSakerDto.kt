package no.nav.lydia.abc.team

import kotlinx.serialization.Serializable
import no.nav.lydia.abc.samarbeidsperiode.IASakDto
import no.nav.lydia.abc.tilstandsmaskin.VirksomhetIATilstand

@Serializable
data class MineSakerDto(
    val iaSak: IASakDto,
    val orgnavn: String,
    val virksomhetTilstand: VirksomhetIATilstand,
)
