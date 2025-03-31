package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.IAProsessService

@Serializable
data class KanFullføreSamarbeidDto(
    val kanFullføres: Boolean,
    val begrunnelser: List<IAProsessService.StatusendringBegrunnelser>,
)
