package no.nav.lydia.virksomhet.domene

import kotlinx.datetime.Instant
import kotlinx.datetime.LocalDate

data class Virksomhet(
    val id: Long,
    val orgnr: String,
    val navn: String,
    val status: VirksomhetStatus,
    val oppstartsdato: LocalDate?,
    val adresse: List<String>,
    val postnummer: String,
    val poststed: String,
    val kommune: String,
    val kommunenummer: String,
    val land: String,
    val landkode: String,
    val næringsgrupper: List<Næringsgruppe>,
    val sektor: String?,
    val oppdatertAvBrregOppdateringsId: Long?,
    val opprettetTidspunkt: Instant,
    val sistEndretTidspunkt: Instant?,
)

enum class VirksomhetStatus {
    AKTIV, FJERNET, SLETTET
}

