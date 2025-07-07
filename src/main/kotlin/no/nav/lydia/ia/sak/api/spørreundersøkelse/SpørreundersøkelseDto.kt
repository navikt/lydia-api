package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørsmålDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SvaralternativDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.UndertemaDomene

@Serializable
data class SpørreundersøkelseDto(
    val id: String,
    @Deprecated("Bruk id")
    val kartleggingId: String,
    val samarbeidId: Int,
    @Deprecated("Bruk samarbeidId")
    val prosessId: Int,
    val status: SpørreundersøkelseDomene.Status,
    val temaer: List<TemaDto>,
    @Deprecated("Bruk temaer")
    val temaMedSpørsmålOgSvaralternativer: List<TemaDto>,
    val opprettetAv: String,
    val type: SpørreundersøkelseDomene.Type,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val gyldigTilTidspunkt: LocalDateTime,
)

@Serializable
data class TemaDto(
    val temaId: Int,
    val navn: String,
    val spørsmålOgSvaralternativer: List<SpørsmålDto>,
)

@Serializable
data class SpørsmålDto(
    val id: String,
    val undertemanavn: String,
    val spørsmål: String,
    val svaralternativer: List<SvaralternativDto>,
    val flervalg: Boolean,
)

fun SpørreundersøkelseDomene.tilDto(): SpørreundersøkelseDto =
    SpørreundersøkelseDto(
        id = id.toString(),
        kartleggingId = id.toString(),
        samarbeidId = samarbeidId,
        prosessId = samarbeidId,
        status = status,
        temaer = temaer.map { it.toDto() },
        temaMedSpørsmålOgSvaralternativer = temaer.map { it.toDto() },
        opprettetAv = opprettetAv,
        type = type,
        opprettetTidspunkt = opprettetTidspunkt,
        endretTidspunkt = endretTidspunkt,
        påbegyntTidspunkt = påbegyntTidspunkt,
        fullførtTidspunkt = fullførtTidspunkt,
        gyldigTilTidspunkt = gyldigTilTidspunkt,
    )

fun TemaDomene.toDto(): TemaDto =
    TemaDto(
        temaId = this.id,
        navn = this.navn,
        spørsmålOgSvaralternativer = this.undertemaer.tilDto(),
    )

fun List<UndertemaDomene>.tilDto(): List<SpørsmålDto> = flatMap { undertema -> undertema.spørsmål.map { it.tilDto(undertemanavn = undertema.navn) } }

fun SpørsmålDomene.tilDto(undertemanavn: String): SpørsmålDto =
    SpørsmålDto(
        id = id.toString(),
        undertemanavn = undertemanavn,
        spørsmål = tekst,
        svaralternativer = svaralternativer.map { it.tilDto() },
        flervalg = flervalg,
    )

@Serializable
data class SvaralternativDto(
    val svarId: String,
    val svartekst: String,
)

fun SvaralternativDomene.tilDto(): SvaralternativDto =
    SvaralternativDto(
        svarId = id.toString(),
        svartekst = tekst,
    )
