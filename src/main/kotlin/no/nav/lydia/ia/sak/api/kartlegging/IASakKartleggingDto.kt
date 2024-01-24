package no.nav.lydia.ia.sak.api.kartlegging

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASakKartlegging
import java.util.UUID

@Serializable
data class IASakKartleggingDto (
    val kartleggingId: String,
    val status: String,
    val spørsmålOgSvaralternativer: List<SpørsmålOgSvaralternativerDto>
)

fun List<IASakKartlegging>.toDto() = map { it.toDto() }
fun IASakKartlegging.toDto() = IASakKartleggingDto(
    kartleggingId = kartleggingId.toString(),
    status = status,
    spørsmålOgSvaralternativer = spørsmålOgSvaralternativerTest
)

// -- for test
private val spørsmålOgSvaralternativerTest = listOf(
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
