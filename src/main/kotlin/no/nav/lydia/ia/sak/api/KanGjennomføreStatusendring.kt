package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.IASamarbeidService

@Serializable
data class KanGjennomføreStatusendring(
    val kanGjennomføres: Boolean,
    val advarsler: List<IASamarbeidService.StatusendringBegrunnelser>,
    val blokkerende: List<IASamarbeidService.StatusendringBegrunnelser>,
)
