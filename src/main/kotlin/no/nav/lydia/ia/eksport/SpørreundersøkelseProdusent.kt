package no.nav.lydia.ia.eksport

import java.time.LocalDate.now
import java.util.UUID
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.ia.sak.api.kartlegging.SpørsmålOgSvaralternativerDto
import no.nav.lydia.ia.sak.api.kartlegging.SvaralternativDto
import no.nav.lydia.ia.sak.domene.IASakKartlegging
import no.nav.lydia.ia.sak.domene.SpørreundersøkelseDto

class SpørreundersøkelseProdusent(
    private val produsent: KafkaProdusent,
    private val topic: String,
) {

    fun sendPåKafka(iaSakKartlegging: IASakKartlegging) {
        produsent.sendMelding(
            topic = topic,
            nøkkel = iaSakKartlegging.kartleggingId.toString(),
            verdi = Json.encodeToString(iaSakKartlegging.tilSpørreundersøkelse())
        )
    }

    fun IASakKartlegging.tilSpørreundersøkelse() =
        SpørreundersøkelseDto(
            spørreundersøkelseId = this.kartleggingId.toString(),
            status = this.status,
            type = "kartlegging",
            spørsmålOgSvaralternativer = spørsmålOgSvaralternativerTest,
            avslutningsdato = now().toKotlinLocalDate()
        )
}

// -- for test
val spørsmålOgSvaralternativerTest = listOf(
    SpørsmålOgSvaralternativerDto(
        id = UUID.randomUUID().toString(),
        spørsmål = "Hvilke av disse faktorene tror du har størst innflytelse på sykefraværet der du jobber?",
        kategori = "PARTSSAMARBEID",
        svaralternativer = listOf(
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Arbeidsbelstning"),
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Arbeidstid"),
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Arbeidsforhold"),
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Ledelse"),
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Noe annet"),
        )
    ),
    SpørsmålOgSvaralternativerDto(
        id = UUID.randomUUID().toString(),
        spørsmål = "Velg det tiltaket som du mener best kan bidra til å forebygge sykefraværet",
        kategori = "PARTSSAMARBEID",
        svaralternativer = listOf(
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Bedre oppfølging av ansatte"),
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Tilrettelegging av arbeidsoppgaver"),
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Kompetanseutvikling"),
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Helsefremmende aktiviteter"),
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Noe annet"),
        )
    ),
    SpørsmålOgSvaralternativerDto(
        id = UUID.randomUUID().toString(),
        spørsmål = "Vi har kunnskap og ferdigheter til å gjennomføre forbedringstiltak i virksomheten (planlegge tiltak, gjennomføre og evaluere måloppnåelse)",
        kategori = "PARTSSAMARBEID",
        svaralternativer = listOf(
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Helt uening"),
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Litt uening"),
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Litt enig"),
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Veldig enig"),
            SvaralternativDto(svarId = UUID.randomUUID().toString(), svartekst = "Vet ikke"),
        )
    )
)
//