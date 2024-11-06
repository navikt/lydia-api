package no.nav.lydia.integrasjoner.ssb

import kotlinx.serialization.Serializable

@Serializable
data class NæringsDto(
    val code: String,
    val level: String,
    val name: String,
    val notes: String,
    val parentCode: String,
    val shortName: String,
)
