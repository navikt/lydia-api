package no.nav.lydia.ia.sak.domene.plan

data class PlanTema(
    val id: Int,
    val navn: String,
    val planlagt: Boolean,
    val undertemaer: List<PlanUndertema>,
    val ressurser: List<PlanRessurs>,
)

