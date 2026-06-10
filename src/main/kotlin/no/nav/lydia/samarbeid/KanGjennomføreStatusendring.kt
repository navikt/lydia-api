package no.nav.lydia.samarbeid

import kotlinx.serialization.Serializable

@Serializable
data class KanGjennomføreStatusendring(
    val kanGjennomføres: Boolean,
    val advarsler: List<IASamarbeidService.StatusendringBegrunnelser>,
    val blokkerende: List<IASamarbeidService.StatusendringBegrunnelser>,
)
