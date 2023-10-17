package no.nav.lydia.virksomhet.domene

import ia.felles.definisjoner.bransjer.Bransjer
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
    val bransje: Bransjer? = næringsundergruppe1.tilBransje(),
    val sektor: Sektor?,
    val oppdatertAvBrregOppdateringsId: Long?,
    val opprettetTidspunkt: Instant,
    val sistEndretTidspunkt: Instant,
    val salesforceUrl: String?,
) {
    fun withSalesforceUrl(url: String?): Virksomhet {
        return Virksomhet(
            id = this.id,
            orgnr = this.orgnr,
            navn = this.navn,
            status = this.status,
            oppstartsdato = this.oppstartsdato,
            adresse = this.adresse,
            postnummer = this.postnummer,
            poststed = this.poststed,
            kommune = this.kommune,
            kommunenummer = this.kommunenummer,
            land = this.land,
            landkode = this.landkode,
            næringsundergruppe1 = this.næringsundergruppe1,
            næringsundergruppe2 = this.næringsundergruppe2,
            næringsundergruppe3 = this.næringsundergruppe3,
            næring = this.næring,
            bransje = this.bransje,
            sektor = this.sektor,
            oppdatertAvBrregOppdateringsId = this.oppdatertAvBrregOppdateringsId,
            opprettetTidspunkt = this.opprettetTidspunkt,
            sistEndretTidspunkt = this.sistEndretTidspunkt,
            salesforceUrl = url,
        )
    }
}

enum class VirksomhetStatus {
    AKTIV, FJERNET, SLETTET
}

