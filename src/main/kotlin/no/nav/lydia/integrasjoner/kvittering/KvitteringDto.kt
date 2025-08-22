package no.nav.lydia.integrasjoner.kvittering

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable

@Serializable
data class KvitteringDto(
    val referanseId: String,
    val samarbeidId: Int,
    val dokumentId: String,
    val journalpostId: String,
    val publisertDato: LocalDateTime,
    val type: String,
)
