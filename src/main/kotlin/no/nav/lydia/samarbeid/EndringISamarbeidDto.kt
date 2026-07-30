package no.nav.lydia.samarbeid

import kotlinx.serialization.Serializable

@Serializable
data class EndringISamarbeidDto(
    val typeEndring: String,
    val verdi: String,
)
