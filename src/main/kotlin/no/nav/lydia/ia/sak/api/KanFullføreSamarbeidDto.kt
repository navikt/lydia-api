package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.IASamarbeidService

@Serializable
data class KanFullføreSamarbeidDto(
    val kanFullføres: Boolean,
    val begrunnelser: List<IASamarbeidService.StatusendringBegrunnelser>,
)
