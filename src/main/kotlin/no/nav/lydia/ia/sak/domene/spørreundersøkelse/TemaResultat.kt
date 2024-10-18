package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.datetime.toJavaLocalDateTime
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent.SerializableSpørsmålResultat
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent.SerializableSvarResultat
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent.SerializableTemaResultat
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvarDto
import java.time.LocalDateTime

data class TemaResultat(
    val id: Int,
    val navn: String,
    val status: TemaStatus,
    val rekkefølge: Int,
    val sistEndret: LocalDateTime,
    val spørsmål: List<SpørsmålResultat>,
)

fun Tema.tilResultat(alleSvar: List<SpørreundersøkelseSvarDto>): TemaResultat =
    TemaResultat(
        id = this.tema.id,
        navn = this.tema.navn,
        status = this.tema.status,
        rekkefølge = this.tema.rekkefølge,
        sistEndret = this.tema.sistEndret.toJavaLocalDateTime(),
        spørsmål = this.spørsmål.map { spørsmål ->
            spørsmål.tilResultat(alleSvar)
        },
    )

fun TemaResultat.tilKafkaMelding(): SerializableTemaResultat =
    SerializableTemaResultat(
        temaId = id,
        navn = navn,
        spørsmålMedSvar = spørsmål.map { spørsmål ->
            SerializableSpørsmålResultat(
                spørsmålId = spørsmål.spørsmålId.toString(),
                tekst = spørsmål.spørsmåltekst,
                flervalg = spørsmål.flervalg,
                svarListe = spørsmål.svaralternativer.map { svar ->
                    SerializableSvarResultat(
                        svarId = svar.svarId.toString(),
                        tekst = svar.svartekst,
                        antallSvar = svar.antallSvar,
                    )
                },
            )
        },
    )
