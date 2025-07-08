package no.nav.lydia.ia.sak.api.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Undertema

@Serializable
data class SpørreundersøkelseDto(
    val id: String,
    val samarbeidId: Int,
    val opprettetAv: String,
    val type: Spørreundersøkelse.Type,
    val status: Spørreundersøkelse.Status,
    val opprettetTidspunkt: LocalDateTime,
    val gyldigTilTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val temaer: List<TemaDto>,
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
    val flervalg: Boolean,
    val svaralternativer: List<SvaralternativDto>,
)

@Serializable
data class SvaralternativDto(
    val svarId: String,
    val svartekst: String,
)

fun Spørreundersøkelse.tilDto(): SpørreundersøkelseDto =
    SpørreundersøkelseDto(
        id = id.toString(),
        type = type,
        status = status,
        samarbeidId = samarbeidId,
        opprettetAv = opprettetAv,
        opprettetTidspunkt = opprettetTidspunkt,
        gyldigTilTidspunkt = gyldigTilTidspunkt,
        endretTidspunkt = endretTidspunkt,
        påbegyntTidspunkt = påbegyntTidspunkt,
        fullførtTidspunkt = fullførtTidspunkt,
        temaer = temaer.map { it.tilDto() },
    )

fun Tema.tilDto(): TemaDto =
    TemaDto(
        temaId = this.id,
        navn = this.navn,
        spørsmålOgSvaralternativer = this.undertemaer.tilDto(),
    )

fun List<Undertema>.tilDto(): List<SpørsmålDto> = flatMap { undertema -> undertema.spørsmål.map { it.tilDto(undertemanavn = undertema.navn) } }

fun Spørsmål.tilDto(undertemanavn: String): SpørsmålDto =
    SpørsmålDto(
        id = id.toString(),
        spørsmål = tekst,
        flervalg = flervalg,
        undertemanavn = undertemanavn,
        svaralternativer = svaralternativer.map { it.tilDto() },
    )

fun Svaralternativ.tilDto(): SvaralternativDto =
    SvaralternativDto(
        svarId = id.toString(),
        svartekst = tekst,
    )
