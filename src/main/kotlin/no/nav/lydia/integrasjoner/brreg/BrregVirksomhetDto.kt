package no.nav.lydia.integrasjoner.brreg

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.exceptions.UgyldigAdresseException
import no.nav.lydia.virksomhet.VirksomhetLagringDao
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.VirksomhetStatus

@Serializable
data class BrregVirksomhetDto(
    val organisasjonsnummer: String,
    val oppstartsdato: String? = null,
    val navn: String,
    val beliggenhetsadresse: Adresse? = null,
    val postadresse: Adresse? = null,
    val naeringskode1: NæringsundergruppeBrreg? = null,
    val naeringskode2: NæringsundergruppeBrreg? = null,
    val naeringskode3: NæringsundergruppeBrreg? = null,
) {
    fun hentNæringsgruppekoder() =
        mutableMapOf(
            "naeringskode1" to hentNæringskode1(),
        ).apply {
            naeringskode2?.let { this["naeringskode2"] = it.kode }
            naeringskode3?.let { this["naeringskode3"] = it.kode }
        }

    private fun hentNæringskode1() = (naeringskode1?.kode ?: Næringsgruppe.UOPPGITT.kode)
}

fun BrregVirksomhetDto.tilVirksomhet(
    status: VirksomhetStatus = VirksomhetStatus.AKTIV,
    oppdateringsId: Long?,
): VirksomhetLagringDao {
    val adresse = hentGyldigAdresse()
    return VirksomhetLagringDao(
        orgnr = organisasjonsnummer,
        navn = navn,
        status = status,
        kommunenummer = adresse.kommunenummer!!,
        næringsgrupper = hentNæringsgruppekoder().toMap(),
        poststed = adresse.poststed!!,
        postnummer = adresse.postnummer!!,
        kommune = adresse.kommune!!,
        land = adresse.land!!,
        landkode = adresse.landkode!!,
        oppstartsdato = oppstartsdato?.let { LocalDate.parse(it) },
        oppdatertAvBrregOppdateringsId = oppdateringsId,
        adresse = adresse.adresse ?: emptyList(),
    )
}

private fun BrregVirksomhetDto.hentGyldigAdresse() =
    if (beliggenhetsadresse != null && beliggenhetsadresse.erRelevant()) {
        beliggenhetsadresse
    } else if (postadresse != null && postadresse.erRelevant()) {
        postadresse
    } else {
        throw UgyldigAdresseException(
            "Adresse for orgnr $organisasjonsnummer inneholder ugyldige verdier for lagring",
        )
    }

@Serializable
data class NæringsundergruppeBrreg(
    val beskrivelse: String,
    val kode: String,
)

@Serializable
data class Adresse(
    val land: String? = null,
    val landkode: String? = null,
    val postnummer: String? = null,
    val poststed: String? = null,
    val adresse: List<String>? = null,
    val kommune: String? = null,
    val kommunenummer: String? = null,
) {
    fun erRelevant() = listOf(land, landkode, postnummer, poststed, kommune, kommunenummer).all { !it.isNullOrBlank() }
}
