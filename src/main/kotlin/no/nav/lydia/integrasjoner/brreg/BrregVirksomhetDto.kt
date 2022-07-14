package no.nav.lydia.integrasjoner.brreg

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.virksomhet.VirksomhetLagringDao
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.VirksomhetStatus

@Serializable
data class BrregVirksomhetDto(
    val organisasjonsnummer: String,
    val oppstartsdato: LocalDate?,
    val navn: String,
    val beliggenhetsadresse: Beliggenhetsadresse? = null,
    val naeringskode1: NæringsundergruppeBrreg? = null,
    val naeringskode2: NæringsundergruppeBrreg? = null,
    val naeringskode3: NæringsundergruppeBrreg? = null,

    ) {
    fun hentNæringsgruppekoder() = mutableMapOf(
        "naeringskode1" to hentNæringskode1()
    ).apply {
        naeringskode2?.let { this["naeringskode2"] = it.kode }
        naeringskode3?.let { this["naeringskode3"] = it.kode }
    }

    private fun hentNæringskode1() = (naeringskode1?.kode ?: Næringsgruppe.UOPPGITT.kode)
}

fun BrregVirksomhetDto.tilVirksomhet(
    status: VirksomhetStatus = VirksomhetStatus.AKTIV,
    oppdateringsId: Long?
): VirksomhetLagringDao {
    if (this.beliggenhetsadresse != null && this.beliggenhetsadresse.erRelevant()) {
        return VirksomhetLagringDao(
            orgnr = organisasjonsnummer,
            navn = navn,
            status = status,
            kommunenummer = beliggenhetsadresse.kommunenummer!!,
            næringsgrupper = hentNæringsgruppekoder().toMap(),
            poststed = beliggenhetsadresse.poststed!!,
            postnummer = beliggenhetsadresse.postnummer!!,
            kommune = beliggenhetsadresse.kommune!!,
            land = beliggenhetsadresse.land!!,
            landkode = beliggenhetsadresse.landkode!!,
            oppstartsdato = oppstartsdato,
            oppdatertAvBrregOppdateringsId = oppdateringsId,
            adresse = beliggenhetsadresse.adresse ?: emptyList()
        )
    }
    throw IllegalArgumentException("Beliggenhetsadresse ${beliggenhetsadresse} for orgnr ${organisasjonsnummer} inneholder ugyldige verdier for lagring")
}

@Serializable
data class NæringsundergruppeBrreg(
    val beskrivelse: String,
    val kode: String
)

@Serializable
data class Beliggenhetsadresse(
    val land: String?,
    val landkode: String?,
    val postnummer: String?,
    val poststed: String?,
    val adresse: List<String>?,
    val kommune: String?,
    val kommunenummer: String?
) {
    // TODO: hva definerer en relevant virksomhet i kontekst av beliggenhet
    fun erRelevant() =
        listOf(land, landkode, postnummer, poststed, kommune, kommunenummer).all { !it.isNullOrBlank() }

}
