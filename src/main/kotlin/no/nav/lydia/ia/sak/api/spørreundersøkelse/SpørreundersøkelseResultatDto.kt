package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene.Companion.MINIMUM_ANTALL_DELTAKERE
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørsmålDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SvaralternativDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.UndertemaDomene

@Serializable
data class SpørreundersøkelseResultatDto(
    val id: String,
    val spørsmålMedSvarPerTema: List<TemaResultatDto>,
)

@Serializable
data class TemaResultatDto(
    val id: Int,
    val navn: String,
    val spørsmålMedSvar: List<SpørsmålResultatDto>,
)

@Serializable
data class SpørsmålResultatDto(
    val id: String,
    val tekst: String,
    val flervalg: Boolean,
    val antallDeltakereSomHarSvart: Int,
    val svarListe: List<SvarResultatDto>,
    val kategori: String,
)

@Serializable
data class SvarResultatDto(
    val id: String,
    val tekst: String,
    val antallSvar: Int,
)

fun SpørreundersøkelseDomene.tilResultatDto(): SpørreundersøkelseResultatDto =
    SpørreundersøkelseResultatDto(
        id = this.id.toString(),
        spørsmålMedSvarPerTema = this.temaer.map { it.tilResultatDto() },
    )

fun TemaDomene.tilResultatDto(): TemaResultatDto =
    TemaResultatDto(
        id = this.id,
        navn = this.navn,
        spørsmålMedSvar = this.undertemaer.tilResultatDto(),
    )

fun List<UndertemaDomene>.tilResultatDto(): List<SpørsmålResultatDto> =
    flatMap { undertema ->
        undertema.spørsmål.map { it.tilResultatDto(undertemanavn = undertema.navn) }
    }

fun SpørsmålDomene.tilResultatDto(undertemanavn: String): SpørsmålResultatDto =
    SpørsmålResultatDto(
        id = id.toString(),
        tekst = tekst,
        flervalg = flervalg,
        antallDeltakereSomHarSvart = if (antallSvar >= MINIMUM_ANTALL_DELTAKERE) antallSvar else 0,
        svarListe = svaralternativer.map { it.tilResultatDto(antallSvarPåSpørsmål = antallSvar) },
        kategori = undertemanavn,
    )

fun SvaralternativDomene.tilResultatDto(antallSvarPåSpørsmål: Int): SvarResultatDto =
    SvarResultatDto(
        id = id.toString(),
        tekst = tekst,
        antallSvar = if (antallSvarPåSpørsmål >= MINIMUM_ANTALL_DELTAKERE) antallSvar else 0,
    )
