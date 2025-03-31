package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.IAProsessService

@Serializable
data class KanGjennomføreStatusendring(
    val kanGjennomføres: Boolean,
    val advarsler: List<IAProsessService.StatusendringBegrunnelser>,
    val blokkerende: List<IAProsessService.StatusendringBegrunnelser>,
)
