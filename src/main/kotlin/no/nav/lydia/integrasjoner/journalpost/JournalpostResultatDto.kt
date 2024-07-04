package no.nav.lydia.integrasjoner.journalpost

import kotlinx.serialization.Serializable

@Serializable
data class JournalpostResultatDto(
    val journalpostId: String,
    val melding: String?,
    val journalpostferdigstilt: Boolean
)
