package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.IASamarbeidService

@Serializable
data class KanSletteSamarbeidDto(
    val kanSlettes: Boolean,
    val begrunnelser: List<IASamarbeidService.StatusendringBegrunnelser>,
)
