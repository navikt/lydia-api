package no.nav.lydia.virksomhet.api

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
    val neringsgrupper: List<Næringsgruppe>,
    val sektor: String,
    val oppdatertAvBrregOppdateringsId: Long? = null,
    val opprettetTidspunkt: Instant,
    val sistEndretTidspunkt: Instant? = null
)

fun Virksomhet.toDto() = VirksomhetDto(
    orgnr = this.orgnr,
    navn = this.navn,
    adresse = this.adresse,
    status = this.status,
    oppstartsdato = oppstartsdato,
    postnummer = this.postnummer,
    poststed = this.poststed,
    neringsgrupper = this.næringsgrupper,
    sektor = sektorKodeTilBeskrivelse(),
    oppdatertAvBrregOppdateringsId = this.oppdatertAvBrregOppdateringsId,
    opprettetTidspunkt = this.opprettetTidspunkt,
    sistEndretTidspunkt = this.sistEndretTidspunkt
)

fun Virksomhet.sektorKodeTilBeskrivelse(): String {
    return when (sektor) {
        "1" -> "Statlig forvaltning"
        "2" -> "Kommunal forvaltning"
        "3" -> "Privat og offentlig næringsvirksomhet"
        else -> "Ukjent"
    }
}
