package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvar
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørsmålResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SvarResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.TemaResultatDto
import java.util.UUID

data class SpørreundersøkelseResultat(
    val id: UUID,
    val saksnummer: String,
    val prosessId: Int,
    val orgnummer: String,
    val virksomhetsNavn: String,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val temaer: List<TemaResultat>,
)

fun Spørreundersøkelse.tilResultat(alleSvar: List<SpørreundersøkelseSvar>): SpørreundersøkelseResultat =
    SpørreundersøkelseResultat(
        id = this.id,
        saksnummer = this.saksnummer,
        prosessId = this.samarbeidId,
        orgnummer = this.orgnummer,
        virksomhetsNavn = this.virksomhetsNavn,
        opprettetAv = this.opprettetAv,
        opprettetTidspunkt = this.opprettetTidspunkt,
        endretTidspunkt = this.endretTidspunkt,
        temaer = this.temaer.map { tema -> tema.tilResultat(alleSvar) },
    )

fun SpørreundersøkelseResultat.tilDto(): SpørreundersøkelseResultatDto =
    SpørreundersøkelseResultatDto(
        id = this.id.toString(),
        spørsmålMedSvarPerTema = this.temaer.map { tema ->
            TemaResultatDto(
                id = tema.id,
                navn = tema.navn,
                spørsmålMedSvar = tema.spørsmål.map { spørsmål ->
                    SpørsmålResultatDto(
                        id = spørsmål.spørsmålId.toString(),
                        tekst = spørsmål.spørsmåltekst,
                        flervalg = spørsmål.flervalg,
                        antallDeltakereSomHarSvart = spørsmål.antallDeltakereSomHarSvart,
                        svarListe = spørsmål.svaralternativer.map { svar ->
                            SvarResultatDto(
                                id = svar.svarId.toString(),
                                tekst = svar.svartekst,
                                antallSvar = svar.antallSvar,
                            )
                        },
                        kategori = spørsmål.undertemanavn
                    )
                },
            )
        },
    )
