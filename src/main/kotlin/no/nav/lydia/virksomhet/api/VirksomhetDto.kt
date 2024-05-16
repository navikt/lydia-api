package no.nav.lydia.virksomhet.api

import ia.felles.definisjoner.bransjer.Bransje
import kotlinx.datetime.Instant
import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.Virksomhet
import no.nav.lydia.virksomhet.domene.VirksomhetStatus

@Serializable
data class VirksomhetDto(
    val orgnr: String,
    val navn: String,
    val status: VirksomhetStatus,
    val oppstartsdato: LocalDate? = null,
    val adresse: List<String>,
    val postnummer: String,
    val poststed: String,
    val oppdatertAvBrregOppdateringsId: Long? = null,
    val opprettetTidspunkt: Instant,
    val sistEndretTidspunkt: Instant,
    val sektor: String,
    val næringsundergruppe1: Næringsgruppe,
    val næringsundergruppe2: Næringsgruppe?,
    val næringsundergruppe3: Næringsgruppe?,
    val næring: Næringsgruppe,
    val bransje: Bransje?
)

fun Virksomhet.toDto() = VirksomhetDto(
    orgnr = this.orgnr,
    navn = this.navn,
    adresse = this.adresse,
    status = this.status,
    oppstartsdato = oppstartsdato,
    postnummer = this.postnummer,
    poststed = this.poststed,
    oppdatertAvBrregOppdateringsId = this.oppdatertAvBrregOppdateringsId,
    opprettetTidspunkt = this.opprettetTidspunkt,
    sistEndretTidspunkt = this.sistEndretTidspunkt,
    sektor = sektor?.beskrivelse ?: "Ukjent",
    næringsundergruppe1 = this.næringsundergruppe1,
    næringsundergruppe2 = this.næringsundergruppe2,
    næringsundergruppe3 = this.næringsundergruppe3,
    næring = this.næring,
    bransje = this.bransje,
)

