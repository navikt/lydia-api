package no.nav.lydia.ia.sak.domene.plan

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable

@Serializable
data class RedigertPlanMalDto(
    val tema: List<RedigertTemaMalDto>,
)

@Serializable
data class RedigertTemaMalDto(
    val rekkefølge: Int,
    val navn: String,
    val planlagt: Boolean,
    val innhold: List<RedigertInnholdMalDto>,
)

@Serializable
data class RedigertInnholdMalDto(
    val rekkefølge: Int,
    val navn: String,
    val planlagt: Boolean,
    val startDato: LocalDate?,
    val sluttDato: LocalDate?,
)
