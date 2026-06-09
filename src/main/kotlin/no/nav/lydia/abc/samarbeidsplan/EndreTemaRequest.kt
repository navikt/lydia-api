package no.nav.lydia.abc.samarbeidsplan

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable

@Serializable
data class EndreTemaRequest(
    val id: Int,
    val inkludert: Boolean,
    val undertemaer: List<EndreUndertemaRequest>,
)

@Serializable
data class EndreUndertemaRequest(
    val id: Int,
    val inkludert: Boolean,
    val startDato: LocalDate?,
    val sluttDato: LocalDate?,
)
