package no.nav.lydia.samarbeidsplan

import kotlinx.serialization.Serializable

@Serializable
data class PlanTemaDto(
    val id: Int,
    val navn: String,
    val inkludert: Boolean,
    val undertemaer: List<PlanUndertemaDto>,
)

fun List<PlanTema>.tilDtoer() = map { it.tilDto() }

fun PlanTema.tilDto(): PlanTemaDto =
    PlanTemaDto(
        id = id,
        navn = navn,
        inkludert = inkludert,
        undertemaer = undertemaer.tilDtoer(),
    )
