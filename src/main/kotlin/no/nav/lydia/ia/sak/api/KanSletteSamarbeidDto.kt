package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.IAProsessService

@Serializable
data class KanSletteSamarbeidDto(
    val kanSlettes: Boolean,
    val begrunnelser: List<IAProsessService.StatusendringBegrunnelser>,
)
