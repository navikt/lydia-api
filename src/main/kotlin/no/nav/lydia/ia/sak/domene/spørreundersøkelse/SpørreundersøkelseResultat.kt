package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvarDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørsmålResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SvarResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.TemaResultatDto
import java.time.LocalDateTime
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
    val tema: List<TemaResultat>,
)

fun Spørreundersøkelse.tilResultat(alleSvar: List<SpørreundersøkelseSvarDto>): SpørreundersøkelseResultat =
    SpørreundersøkelseResultat(
        id = this.id,
        saksnummer = this.saksnummer,
        prosessId = this.samarbeidId,
        orgnummer = this.orgnummer,
        virksomhetsNavn = this.virksomhetsNavn,
        opprettetAv = this.opprettetAv,
        opprettetTidspunkt = this.opprettetTidspunkt,
        endretTidspunkt = this.endretTidspunkt,
        tema = this.tema.map { tema ->
            tema.tilResultat(alleSvar)
        },
    )

fun SpørreundersøkelseResultat.tilDto(): SpørreundersøkelseResultatDto =
    SpørreundersøkelseResultatDto(
        id = this.id.toString(),
        spørsmålMedSvarPerTema = this.tema.map { tema ->
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
                    )
                },
            )
        },
    )
