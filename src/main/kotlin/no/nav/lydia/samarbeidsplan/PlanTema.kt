package no.nav.lydia.samarbeidsplan

data class PlanTema(
    val id: Int,
    val navn: String,
    val inkludert: Boolean,
    val undertemaer: List<PlanUndertema>,
)
