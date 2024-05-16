package no.nav.lydia.virksomhet.domene

import ia.felles.definisjoner.bransjer.Bransje
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
    val næringsundergruppe1: Næringsgruppe,
    val næringsundergruppe2: Næringsgruppe?,
    val næringsundergruppe3: Næringsgruppe?,
    val næring: Næringsgruppe,
    val bransje: Bransje? = næringsundergruppe1.tilBransje(),
    val sektor: Sektor?,
    val oppdatertAvBrregOppdateringsId: Long?,
    val opprettetTidspunkt: Instant,
    val sistEndretTidspunkt: Instant,
)

enum class VirksomhetStatus {
    AKTIV, FJERNET, SLETTET
}

